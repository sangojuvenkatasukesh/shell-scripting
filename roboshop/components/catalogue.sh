#!bin/bash
source components/common.sh

Print "Installing NodeJS"
yum install nodejs make gcc-c++ -y  &>>$LOG
Status_check $?

Print "Adding roboshop user"
useradd roboshop &>>$LOG
Status_check $?

Print "Downloading Catalogue Content"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
Status_check $?

Print "Extracting Catalogue"
cd /home/roboshop
unzip -o /tmp/catalogue.zip &>>$LOG
mv catalogue-main catalogue
Status_check $?

cd /home/roboshop/catalogue
npm install  &>>$LOG


# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue