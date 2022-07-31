#!/bin/bash

ROOT_UID=0
NOTROOT_UID=100

AWS_ACCESS_KEY=$(aws --region=us-east-1 ssm get-parameter --name "access-key-id" --with-decryption --output text --query Parameter.Value)
AWS_SECRET_KEY=$(aws --region=us-east-1 ssm get-parameter --name "secret-key" --with-decryption --output text --query Parameter.Value)
AWS_DEFAULT_REGION=us-east-1

if [ "$UID" -ne "$ROOT_UID" ]
then 
	echo "Must be a sudo user to run this script"
	exit "$NOTROOT_UID"
fi

source task03.sh

aws configure set aws_access_key_id $AWS_ACCESS_KEY
aws configure set aws_secret_key "$AWS_SECRET_KEY"
aws configure set default.region "$AWS_DEFAULT_REGION"

echo "AWS_ACCESS_KEY_ID is" ${AWS_ACCESS_KEY}
echo "AWS_SECRET_KEY is" ${AWS_SECRET_KEY}
