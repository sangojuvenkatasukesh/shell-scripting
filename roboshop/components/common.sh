Status_Check() {
if [ $? -eq 0 ];then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit 2
fi    
}

Print() {
    echo -e "\n\t\t\e[36m------------$1--------------\e[0m\n" &>>$LOG
    echo -n -e "$1 - "
}

if [ $UID -ne 0 ]; then
    echo -e "\n\e[1;33mYou Should Execute this Script as a root user\e[0m\n"
    exit 1
 fi
LOG=/tmp/roboshop.log
rm -f $LOG

APP_ADD_USER() {
Print "Adding Roboshop User\t\t\t"
id roboshop &>>$LOG
if [ $? -eq 0 ];then
echo "User already exists, So skipping" &>>$LOG
else
useradd roboshop  &>>$LOG
 fi
Status_Check $?
}
 
DOWNLOAD() {
 Print "Downloading ${COMPONENT} Content\t\t"
curl -s -L -o /tmp/${COMPONENT} .zip "https://github.com/roboshop-devops-project/${COMPONENT} /archive/main.zip"
Status_Check $?
Print "Extracting ${COMPONENT} \t\t\t"
cd /home/roboshop
rm -rf ${COMPONENT}  && unzip -o /tmp/${COMPONENT} .zip  &>>$LOG && mv ${COMPONENT} -main ${COMPONENT} 
Status_Check $?
}

SystemdD_setup() {
Print "Update Systemd Service\t\t\t"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/'  /home/roboshop/${COMPONENT}/systemd.service
Status_Check $?
Print "Setup Systemd Service\t\t\t"
mv /home/roboshop/ ${COMPONENT} /systemd.service  /etc/systemd/system/${COMPONENT}.service && systemctl daemon-reload && systemctl restart  ${COMPONENT}  &>>$LOG
systemctl enable  ${COMPONENT}   &>>$LOG
Status_Check $?
}
NODEJS() {
Print "Installing NODEJS\t\t\t"
yum install nodejs make gcc-c++ -y  &>>$LOG
Status_Check $?
ADD_APP_USER
DOWNLOAD
Print "Downloading NodeJS Dependencies\t\t"
cd /home/roboshop/${COMPONENT} 
 npm install --unsafe-perm  &>>$LOG
 Status_Check $?
chown roboshop:roboshop -R /home/roboshop
SystemdD_setup
}