#!bin/bash
Status_Check() {
if [ $? -eq 0 ];then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit 2
fi    
}
echo "Setting up Mongodb repo"

echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
Status_Check $?
echo "Installing Mongodb"
yum install -y mongodb-org  &>>/tmp/log
Status_Check $?
echo "Configuring Mongodb"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
Status_Check $?

echo "Starting Mongodb"
systemctl enable mongod
systemctl restart mongod
Status_Check $?

echo "Downloading Mongodb"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
Status_Check $?
cd /tmp
echo "Extracting schema Archive"
unzip -o mongodb.zip &>>/tmp/log
Status_Check $?
 cd mongodb-main
 echo "Loading schema"
 mongo < catalogue.js &>>/tmp/log
 mongo < users.js  &>>/tmp/log
Status_Check $?
