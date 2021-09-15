Status_Check() {
if [ $? -eq 0 ];then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit 2
fi    
}

Print() {
    echo -n -e "$1 - "
}

if [UID -ne 0 ]; then
    echo -e "\n\e[1;33mYou Should Execute this Script as a root user\e[0m\n"
    exit 1
 fi