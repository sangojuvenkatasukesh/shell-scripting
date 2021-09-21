#!bin/bash

source components/common.sh


Print "Install Yum Utils & Download redis repo"
yum install epel-release http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y  &>>$LOG
Status_Check $?
 
Print " Setup Redis Repo"
yum-config-manager --enable remi &>>$LOG


Print " Install Redis"
yum install redis -y  &>>$LOG
Status_Check $?

Print "Configure Redis Listen Address"
sed -i -e's/127.0.0.1/ 0.0.0.0/'  /etc/redis.conf 
Status_Check $?

Print "Start Redis Service"
systemctl enable redis &>>$LOG && systemctl start redis  &>>$LOG
Status_Check $?