locals {
  policy_arn = {
    AWSLambdaBasicExecutionRole    = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    AWSLambdaSQSQueueExecutionRole = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
    AmazonSSMReadOnlyAccess        = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess" 
  }
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "slack-notify-lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  for_each = local.policy_arn

  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = each.value
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.function.arn
  principal     = "events.amazonaws.com"
}