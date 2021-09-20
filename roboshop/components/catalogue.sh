#!bin/bash

source components/common.sh

Print "Installing NODEJS"
yum install nodejs make gcc-c++ -y  &>>$LOG
Status_Check $?

Print "Adding Roboshop User"
id roboshop &>>$LOG
if [ $? -eq 0 ];then
echo "User already exists, So skipping" &>>$LOG
else
useradd roboshop  &>>$LOG
 fi
Status_Check $?

Print "Downloading Catalogue Content"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
Status_Check $?

Print "Extracting Catalogue"
cd /home/roboshop
unzip -o /tmp/catalogue.zip  &>>$LOG
mv catalogue-main catalogue
if [ $? -eq 0 ];then
  echo "success"
else 
  echo "failure"
 
Status_Check $?

cd /home/roboshop/catalogue
 npm install --unsafe-perm &>>$LOG


# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue