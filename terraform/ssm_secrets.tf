locals {
  secrets = {
    slack_bot_token = {
      name_prefix = "/slack_notify/SLACK_BOT_TOKEN"
      description = "API Token for Slack Bot"
    }
    slack_channels = {
      name_prefix = "/slack_notify/SLACK_CHANNELS"
      description = "Slack channel IDs mapping"
    }
  }
}

resource "aws_ssm_parameter" "secret" {
  for_each = local.secrets

  name        = each.value.name_prefix
  description = each.value.description
  type        = "SecureString"
  value       = "REPLACE_ME"

  lifecycle {
    ignore_changes = [value]
  }
}