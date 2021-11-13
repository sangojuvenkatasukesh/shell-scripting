#!bin/bash 

source components/common.sh

Print "Install Erlang\t\t\t"
yum list installed | grep erlang   &>>$LOG
if [ $? -eq 0 ]

yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y &>>$LOG
Status_Check $?

Print "Setup YUM repositories for RabbitMQ"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash  &>>$LOG
Status_Check $?

Print "Install RabbitMQ\t\t\t"
yum install rabbitmq-server -y  &>>$LOG
Status_Check $?

Print "Start RabbitMQ\t"
systemctl enable rabbitmq-server   &>>$LOG && systemctl start rabbitmq-server  &>>$LOG
Status_Check $?


Print "Create application user\t"
rabbitmqctl add_user roboshop roboshop123  &>>$LOG && rabbitmqctl set_user_tags roboshop administrator  &>>$LOG   &&rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"  &>>$LOG 
Status_Check $?