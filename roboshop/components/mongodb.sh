#!bin/bash
source components/common.sh

Print "Setting up Mongodb repo\t\t"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
Status_Check $?
Print "Installing Mongodb\t\t"
yum install -y mongodb-org  &>>$LOG
Status_Check $?
Print "Configuring Mongodb\t\t"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
Status_Check $?

Print "Starting Mongodb\t\t"
systemctl enable mongod
systemctl restart mongod
Status_Check $?

Print "Downloading Mongodb\t\t"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
Status_Check $?
cd /tmp
Print "Extracting schema Archive\t"
unzip -o mongodb.zip &>>$LOG
Status_Check $?
 cd mongodb-main
 Print "Loading schema\t\t\t"
 mongo < catalogue.js &>>$LOG
 mongo < users.js  &>>$LOG
Status_Check $?

exit 0
