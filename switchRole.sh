#!/bin/sh

echo "Start of Switch Role"

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
unset AWS_DEFAULT_REGION

# switch role
aws sts assume-role --role-arn $1 --role-session-name rdp-develop-access > assume-role-output.txt
export AWS_ACCESS_KEY_ID=`cat assume-role-output.txt | jq -r '.Credentials.AccessKeyId'`
export AWS_SECRET_ACCESS_KEY=`cat assume-role-output.txt | jq -r '.Credentials.SecretAccessKey'`
export AWS_SESSION_TOKEN=`cat assume-role-output.txt | jq -r '.Credentials.SessionToken'`
export AWS_DEFAULT_REGION=$2

echo "End of Switch Role
