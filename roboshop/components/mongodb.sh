echo "Setting up Mongodb repo"

echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
echo "Installing Mongodb"
yum install -y mongodb-org  &>>/tmp/log
echo "Configuring Mongodb"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

echo "Starting Mongodb"
systemctl enable mongod
systemctl restart mongod
if [ $? -eq 0];then
    echo -e "\e[32mSUCCESS\e[0m"
  else
  echo -e "\e[31mFAILURE\e[0m"
fi

echo "Downloading Mongodb"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
if [ $? -eq 0];then
    echo -e "\e[32mSUCCESS\e[0m"
  else
  echo -e "\e[31mFAILURE\e[0m"
fi
cd /tmp
echo "Extracting schema Archive"
unzip -o mongodb.zip &>>/tmp/log
if [ $? -eq 0];then
    echo -e "\e[32mSUCCESS\e[0m"
  else
  echo -e "\e[31mFAILURE\e[0m"
fi
 cd mongodb-main
 echo "Loading schema"
 mongo < catalogue.js &>>/tmp/log
 mongo < users.js  &>>/tmp/log
if [ $? -eq 0];then
    echo -e "\e[32mSUCCESS\e[0m"
  else
  echo -e "\e[31mFAILURE\e[0m"
fi

