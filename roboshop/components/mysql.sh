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
echo  "ALTER USER 'root'@'localhost' IDENTIFIED BY 'pRoboShop@1'; "  >mysql -u root
mysql --connect-expired-password -u root -p"{DEFAULT_PASSWORD}"  </tmp/reset.mysql  &>>$LOG
fi
Status_Check $?
exit  





Run the following SQL commands to remove the password policy.
> uninstall plugin validate_password;
Setup Needed for Application.
As per the architecture diagram, MySQL is needed by

Shipping Service
So we need to load that schema into the database, So those applications will detect them and run accordingly.

To download schema, Use the following command

# curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"
Load the schema for Services.

# cd /tmp
# unzip mysql.zip
# cd mysql-main
# mysql -u root -pRoboShop@1  <shipping.sql