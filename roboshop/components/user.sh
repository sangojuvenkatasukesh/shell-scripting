!bin/bash

source components/common.sh

Print "Installing NODEJS\t\t\t"
yum install nodejs make gcc-c++ -y  &>>$LOG
Status_Check $?

Print "Adding Roboshop User\t\t\t"
id roboshop &>>$LOG
if [ $? -eq 0 ];then
echo "User already exists, So skipping" &>>$LOG
else
useradd roboshop  &>>$LOG
 fi
Status_Check $?

Print "Downloading User Content\t\t"
curl -s -L -o /tmp/user.zip "https://github.com/roboshop-devops-project/user/archive/main.zip"
Status_Check $?

Print "Extracting User\t\t\t"
cd /home/roboshop
rm -rf user  && unzip -o /tmp/user.zip  &>>$LOG && mv user-main user
Status_Check $?

Print "Downloading NodeJS Dependencies\t\t"
cd /home/roboshop/user
 npm install --unsafe-perm &>>$LOG
 Status_Check $?

chown roboshop:roboshop -R /home/roboshop

Print "Update Systemd Service\t\t\t"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/'  /home/roboshop/user/systemd.service
Status_Check $?

Print "Setup Systemd Service\t\t\t"
mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service && systemctl daemon-reload && systemctl restart user &>>$LOG
systemctl enable user  &>>$LOG
Status_Check $?