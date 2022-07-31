#!/bin/bash

ROOT_UID=0
NOTROOT_UID=100

if [ "$UID" -ne "$ROOT_UID" ]
then
	echo "Must be a sudo user to run this script"
	exit "$NOTROOT_UID"
fi

source task04.sh

AWS_DEFAULT_REGION=us-east-1
COUNT=1

declare -A instance0=(
	[region]=$AWS_DEFAULT_REGION
	[instanceType]='t2.micro'
	[keyName]='assignment-2'
	[availabilityZone]='us-east-1a'
	[instanceName]='ubuntu-server-01'
	[ami]='ami-052efd3df9dad4825'
	[securityGroup]='assignment-02-sg'
)

declare -A instance1=(
[region]=$AWS_DEFAULT_REGION
        [instanceType]='t2.micro'
        [keyName]='assignment-2'
        [availabilityZone]='us-east-1b'
        [instanceName]='ubuntu-server-02'
        [ami]='ami-052efd3df9dad4825'
        [securityGroup]='assignment-02-sg'
)

declare -n instance
for instance in ${!instance@}; do
	SECURITY_GROUP=$(aws ec2 describe-security-groups --filter "Name=group-name,Values=${instance[securityGroup]}" --query "SecurityGroups[*].GroupId" --output text)
    SUBNET_ID=$(aws ec2 describe-subnets --filters "Name=availability-zone,Values=${instance[availabilityZone]}" --query "Subnets[*].SubnetId" --output text)
    TAG="ResourceType=instance,Tags=[{Key=Name,Value=${instance[instanceName]}}]"
	aws ec2 run-instances\
	--image-id ${instance[ami]} \
	--count ${COUNT} \
	--instance-type ${instance[instanceType]} \
	--key-name ${instance[key-name]} \
	--security-group-ids ${SECURITY_GROUP} \
	--subnet-id ${SUBNET_ID} \
	--tag-specifications ${TAG} > /dev/null
	
	echo "Successfully launched an EC2 instance"
done
