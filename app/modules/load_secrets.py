import boto3 
import sys
import json

def load_slack_channel_ids(SSM_SLACK_CHANNELS, REGION):
    try:
        
        ssm = boto3.client("ssm", region_name=REGION)

        response = ssm.get_parameter(
        Name = SSM_SLACK_CHANNELS,
        WithDecryption=True  
        )
        response = json.loads(response["Parameter"]["Value"])
        return(response)

    except Exception as e:
        print(f" FATAL: Could not retrieve Slack Channels secrets. {e}")
        sys.exit(1)    

def load_slack_bot_secet(SSM_SLACK_BOT_TOKEN, REGION):
    try:
        ssm = boto3.client("ssm", region_name=REGION)

        response = ssm.get_parameter(
        Name = SSM_SLACK_BOT_TOKEN,
        WithDecryption=True  
        )

        response = response["Parameter"]["Value"]
        return(response)

    except Exception as e:
        print(f" FATAL: Could not retrieve Slack Bot secrets. {e}")
        sys.exit(1)    

#if __name__ == "__main__":
#    REGION = "ap-southeast-2"
#    #SSM_SLACK_CHANNELS = "/slack_notify/SLACK_CHANNELS"  # your actual param name
#    SSM_SLACK_BOT_TOKEN = "/slack_notify/SLACK_BOT_TOKEN"  # your actual param name
#    
#   # a = load_slack_channel_ids(SSM_SLACK_CHANNELS, REGION)
#    b = load_slack_bot_secet(SSM_SLACK_BOT_TOKEN, REGION)
#    print(b)