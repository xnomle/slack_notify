import boto3

def get_ec2_details(event):

    account_number = event.get('account')
    region         = event.get('region')
    alert_time     = event.get('time')

    
    details = event.get('detail', {})
    
    
    resources     = event.get("resources", [])
 
    instance_id   = details.get('instance-id')
    state         = details.get('state')

    
    ec2_client = boto3.client('ec2', region_name=region)
    
    try:
        response = ec2_client.describe_instances(
            InstanceIds=[instance_id]
        )

        instance_data = response['Reservations'][0]['Instances'][0]
        
        reason = instance_data.get('StateTransitionReason', 'Unknown')

        
        message_blocks = [
            {
                "type": "header",
                "text": {
                    "type": "plain_text",
                    "text": "🚨 EC2 Instance State Change"
                }
            },
            {
                "type": "section",
                "fields": [
                    {
                        "type": "mrkdwn",
                        "text": f"*Account Number:*\n{account_number}"
                    },
                    {
                        "type": "mrkdwn",
                        "text": f"*Region:*\n{region}"
                    },
                    {
                        "type": "mrkdwn",
                        "text": f"*Alert Time:*\n{alert_time}"
                    },
                    {
                        "type": "mrkdwn",
                        "text": "*Resource:*\nEC2"
                    },
                    {
                        "type": "mrkdwn",
                        "text": f"*Instance ID:*\n{instance_id}"
                    },
                    {
                        "type": "mrkdwn",
                        "text": f"*New State:*\n{state}"
                    },
                    {
                        "type": "mrkdwn",
                        "text": f"*Reason:*\n{reason}"
                    }
                ]
            }
        ]

        return message_blocks

    except Exception as e:
        return f"Error getting details for {instance_id}. Error: {str(e)}"