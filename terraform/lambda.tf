resource "null_resource" "install_dependencies" {
  triggers = {
    requirements_hash = "${path.module}/../app/requirements.txt"
    app_hash          = "${path.module}/../app/main.py"
    module_hash       = "${path.module}/../app/modules"
  }
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/build"
  output_path = "${path.module}/lambda_package.zip"
}

resource "aws_lambda_function" "function" {

  function_name    = "slack-notify"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "main.lambda_handler"
  runtime          = "python3.12"

  memory_size = 128
  timeout     = 30

  dead_letter_config {
    target_arn = aws_sqs_queue.lambda_dlq.arn
  }

  environment {
    variables = {
      SLACK_BOT_TOKEN = aws_ssm_parameter.secret["slack_bot_token"].name
      SLACK_CHANNELS  = aws_ssm_parameter.secret["slack_channels"].name
    }
  }
}

resource "aws_sqs_queue" "lambda_dlq" {
  name                      = "slack-notify-dlq"
  message_retention_seconds = 345600 # 4 days 
}

