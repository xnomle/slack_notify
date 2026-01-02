module "eventbridge" {
  source = "terraform-aws-modules/eventbridge/aws"

  create_bus = false

  log_config = {
    include_detail = "FULL"
    level          = "INFO"
  }

  rules = {
    ecs = {
      description = "Capture ecs state change"
      event_pattern = jsonencode({ "source" : ["aws.ecs"],
      "detail-type" : ["ECS Task State Change"] })
      enabled = true
    }
    ec2 = {
      description = "ec2 terminated"
      event_pattern = jsonencode({
        "source" : ["aws.ec2"],
        "detail-type" : ["EC2 Instance State-change Notification"],
      })
      enabled = true

    }
  }

  targets = {
    ecs = [
      {
        name = "Send ECS State Change To Slack"
        arn  = aws_lambda_function.function.arn
      }
    ]

    ec2 = [
      {
        name = "Send EC2 State Change To Slack"
        arn  = aws_lambda_function.function.arn
      }
    ]
  }
}