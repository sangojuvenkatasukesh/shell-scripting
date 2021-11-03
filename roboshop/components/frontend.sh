#!bin/bash

source components/common.sh
 
Print "Installing Nginx\t\t"
yum install nginx -y  &>>$LOG
Status_Check $?

Print "DownLoad Frontend Archive\t"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"  &>>$LOG
Status_Check $?

Print "Extract Frontend Archive\t"
rm -rf /usr/share/nginx/* && cd /usr/share/nginx  &&  unzip -o /tmp/frontend.zip  &>>$LOG  && mv frontend-main/* .  
&>>$LOG  &&   mv static html   &>>$LOG
Status_Check $?

Print "Copy Roboshop Config File\t"
mv localhost.conf /etc/nginx/default.d/roboshop.conf    &>>$LOG
Status_Check $?

Print "Update Roboshop Config File\t"
sed -i -e '/catalogue/ s/localhost/catalogue.roboshop.internal/' /etc/nginx/default.d/roboshop.conf &>>$LOG
Status_Check $?


Print "Starting Nginx\t\t\t"
systemctl restart nginx   &>>$LOG  &&   systemctl enable nginx   &>>$LOG