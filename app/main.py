import requests
import os
import json
import boto3
import sys
from modules.ec2 import get_ec2_details
from modules.load_secrets import load_slack_bot_secet, load_slack_channel_ids

REGION ="ap-southeast-2"
SSM_SLACK_BOT_TOKEN = os.getenv("SLACK_BOT_TOKEN")
SSM_SLACK_CHANNELS = os.getenv("SLACK_CHANNELS")

def get_ecs_details():
    pass
             
def get_cloudwatch_details():
    pass

def send_slack_message(SLACK_BOT_TOKEN, message_block, slack_channel_id):
    url = "https://slack.com/api/chat.postMessage"

    headers = {
        "Authorization": f"Bearer {SLACK_BOT_TOKEN}",
        "Content-Type": "application/json; charset=utf-8"
    }

    payload = {
        "channel": slack_channel_id,
        "username": "ZenBot",
        "blocks": message_block
    }
    
    response = requests.post(url, headers=headers, json=payload)
    print(response)
    response_data = response.json()
    print(response_data)
    return response_data

def lambda_handler(event, context):
    print(f"Received event: {json.dumps(event)}")

    slack_bot_token = load_slack_bot_secet(SSM_SLACK_BOT_TOKEN, REGION)

    slack_channels = load_slack_channel_ids(SSM_SLACK_CHANNELS, REGION)
    slack_channel_id = slack_channels["it-test-channel"]

    # pull alert type 
    source = event.get('source')

    # grab details of event and pass to function. 

    if "ec2" in source:
        message_block = get_ec2_details(event)
    elif "ecs" in source: 
        message_block = get_ecs_details(event)
    else: 
        message_block = get_cloudwatch_details(event)
    
    slack_response = send_slack_message(slack_bot_token, message_block, slack_channel_id)

    return slack_response 