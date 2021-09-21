#!bin/bash

source components/common.sh
Print "Install Yum  Utils & Download Redis Repo"
yum install epel-release yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>$LOG
 Status_Check $?
 
  Print "Setup Redis repo"
yum-config-manager --enable remi &>>$LOG
 Status_Check $?

Print  "Install Redis"
 yum install redis -y &>>$LOG
 Status_Check $?
 
 Print "Configure Redis Listen Address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
 Status_Check $?

Print "Start Database"
systemctl enable redis  &>>$LOG && systemctl start redis  &>>$LOG
Status_Check $?