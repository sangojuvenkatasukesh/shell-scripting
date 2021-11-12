#!bin/bash

source components/common.sh

Print "Setup MySQL Repo\t"
echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
Status_Check $?

Print "Install MySQL Service\t"
yum remove mariadb-libs -y  &>>$LOG  &&  yum install mysql-community-server -y   &>>$LOG
Status_Check $?

Print "Start MySQL Service\t"
systemctl enable mysqld   &>>$LOG && systemctl start mysqld  &>>$LOG
Status_Check $?

DEFAULT_PASSWORD=$( grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}'
)

Print "Reset Default Password"
echo 'show databases' |  mysql -u root -pRoboShop@1   &>>$LOG
if [ $? -eq 0 ]; then
echo "Password is already set"  &>>$LOG
else 
echo  "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1'; "  >/tmp/reset.mysql
mysql --connect-expired-password -u root -p"{DEFAULT_PASSWORD}"  </tmp/reset.mysql &>>$LOG
fi
Status_Check $?
exit  


Print "Unistall Password Validate Plugin"
echo "Unistall plugin Validate-password;" >/tmp/pass.mysql 
mysql -u root -p"RoboShop@1 "  </tmp/reset.mysql &>>$LOG
Status_Check $?



Print "Download the Schema"
curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip" &>>$LOG
Status_Check $?

Print "E"
# cd /tmp
# unzip mysql.zip
# cd mysql-main
# mysql -u root -pRoboShop@1  <shipping.sql