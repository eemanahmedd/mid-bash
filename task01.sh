#!/bin/bash

ROOT_UID=0
NOT_ROOT=100

if [ "$UID" -ne "$ROOT_UID" ]
then
echo "Not a sudo user"
exit "$NOT_ROOT"
fi

echo "Updating and upgrading packages please wait..."

apt-get update > /dev/null
apt-get upgrade > /dev/null

which nginx &> /dev/null || {
	echo "Installing nginx..."
	apt install nginx -y > /dev/null
	echo "Nginx is installed!"
} && {
	echo "Updating and upgrading nginx.."
	apt install nginx --upgrade
	}
echo "Nginx is ready to use"
