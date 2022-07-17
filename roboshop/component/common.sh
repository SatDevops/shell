user-id=$(id-u)
if [$user-id -ne 0]; then 
    echo -e "\e[31m you need to run it as root user only \e[0m"
    exit 
fi 