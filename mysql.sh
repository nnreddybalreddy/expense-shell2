#!/bin/bash
TIMESTAMP=$(date +%F-%M-%H-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo "Enter password"
read mysql_root_password

USERID=$(id -u)

if [ $USERID -eq  0 ]
then
    echo "You are super"
else 
    echo "Not a super user"
    exit 1    
fi

VALIDATE(){
    echo $1
    # if [ $? -eq 0 ]
    # then 
    #     echo -e "$2 $G is success $N"
    # else    
    #     echo -e "$2 $R is fail $N"
}

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

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
VALIDATE $? "password set "

mysql -h db.narendra.shop -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE

if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ${mysql_root_password}  &>>$LOGFILE
else
    echo -e "$Y Password alrady set $N"
fi