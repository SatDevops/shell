#!/bin/bash

set -e
COMPONENT=frontend
LOGFILE="/tmp/$COMPONENT.LOG" 
source component/common.sh

stat(){
	if [$1 -eq 0] ; then
    	echo -n "\e[32m SUCCESS \e[0m"
	else
		echo -n "\e[32m  FAILURE \e[0m"
	fi
}
echo -n "Installing the nginx"
yum install nginx -y &>>LOGFILE
stat $?
systemctl enable nginx &>>LOGFILE

echo -n "Starting the nginx"
systemctl start nginx
stat $?
echo -n "Dwonloading and extracting the file $COMPONENT"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf



