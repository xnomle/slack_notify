import requests
import os

SLACK_BOT_TOKEN = os.getenv("SLACK_BOT_TOKEN")
CHANNEL_IDS = [
    "C098BFJ86ET",    # it-test-channel
    #"it-test-channel"
]

context = {"message": "CPU High", "severity": "warning"}


def send_slack_message(SLACK_BOT_TOKEN, channel, message):
    url = "https://slack.com/api/chat.postMessage"

    headers = {
        "Authorization": f"Bearer {SLACK_BOT_TOKEN}",
        "Content-Type": "application/json; charset=utf-8"
    }

    payload = {
        "channel": channel,
        "username": "ZenBot",
        "text": message
    }
   
    response = requests.post(url, headers=headers, json=payload)
    response_data = response.json()
    print(response_data)


def lambda_handler(event, context):

    slack_channel = event.get("slack_channel")
    print(slack_channel)



#def main():
#    for channel in CHANNEL_IDS:
#        send_slack_message(SLACK_BOT_TOKEN, channel, message)
#
#if __name__ == "__main__":
#    main()
