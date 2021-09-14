#!bin/bash


read -p 'Enter some input : ' input
if  [ -z "$input" ]; then
echo "you have not provided any input"
exit 1
fi

if [ $Input=="ABC" ]; then
echo "input provided is abc"
fi


echo "Input - $input"
if [ $? -eq 0 ]; then
    echo Success
else 
    echo Failure
fi
read -p 'enter file name: ' file
if [ -f $file ]; then
    echo "File exists"
 else
    echo "File Does not exists"
 fi