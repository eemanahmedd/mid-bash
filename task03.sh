#!/bin/bash

ROOT_ID=0
NOT_ROOT=100

if [[ "$UID" -ne "$ROOT_ID" ]]
then 
	echo "Need to be a sudoer to run this script"
	exit $NOT_ROOT
fi

ARCH=$(uname -i)

#echo $arch
which curl &> /dev/null || apt install curl -y && echo "curl is installed"
which unzip &> /dev/null || apt install unzip -y && echo "unzip is installed"

which aws &> /dev/null && {
echo "aws-cli 2.7.9 is already installed in your machine"
 }

which aws &> /dev/null || {
curl -s "https://awscli.amazonaws.com/awscli-exe-linux-$ARCH.zip" -o "awscliv2.zip"
unzip "$PWD/awscliv2.zip" > /dev/null
sudo "$PWD/aws/install" > /dev/null
echo "AWS installed"
}
