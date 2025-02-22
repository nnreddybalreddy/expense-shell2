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

check_root(){
    if [ $USERID -eq  0 ]
    then
        echo "You are super"
    else 
        echo "Not a super user"
        exit 1    
    fi
}

VALIDATE(){
    if [ $1 -eq 0 ]
    then 
        echo -e "$2 $G success $N"
    else 
        echo -e "$2 $G fail $N"
        exit 1     
    fi    
}