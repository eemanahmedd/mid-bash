#!/bin/bash

ROOT_ID=0
NOT_ROOT=100
green='\033[0;32m'
red='\033[0;31m'
white='\033[0m'

if [ "$UID" -ne "$ROOT_ID" ]
then
	echo "Script to be to run by sudoer"
	exit $NOT_ROOT	
fi

status=$(systemctl status nginx | grep Active | awk '{print $2}')

if [[ $status = "active" ]]
then
	echo -e "${green}NGINX is running! ${white}"
else
	echo -e "${red}NGINX is dead. Do you want to run it? [y/n] ${white}"
	read input
	
	if [[ $input =~ ^([yY][eE][sS]|[yY])$ ]]
	then
		systemctl start nginx
		echo -e "${green}NGINX is now successfully activated! ${white}"
	else
		echo -e "${red}Somethng went wrong. NGINX can not be activated ${white}"	
fi
fi
