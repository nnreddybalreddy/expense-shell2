#!/bin/bash
source ./common.sh

# VALIDATE(){
#     if [ $? -eq 0 ]
#     then 
#         echo -e "$2 $G success $N"
#     else 
#         echo -e "$2 $R failure $N"    
#     fi 
# }


dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "mysql server installation"


systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "enable mysqld"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "start mysqld"

mysql -h db.narendra.shop -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE

if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ${mysql_root_password}  &>>$LOGFILE
else
    echo -e "$Y Password alrady set $N"
fi