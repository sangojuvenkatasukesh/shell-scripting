#!bin/bash

source components/common.sh
 
 Print "Installing Nginx"
yum install nginx -y 
Status_Check $?

Print "DownLoad Frontend Archive"
# curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
Deploy in Nginx Default Location.

# cd /usr/share/nginx/html
# rm -rf * 
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-master static README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf
Finally restart the service once to effect the changes.

# systemctl restart nginx 