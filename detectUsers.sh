#i/bin/bash

if [[ -z $1 ]]; 
then
    read -p "Input username for detect : " usernameTarget
else
    usernameTarget=$1
fi


uidTarget=`id -u $usernameTarget`
if [[ -z "$uidTarget" ]]; 
then
    exit
fi

echo ""
echo " START DETECT..."
echo ""
echo " TARGET > UID: $uidTarget / user: $usernameTarget"
echo ""

while true
do
    
    userLoggedNow=`users`
    echo " Timestamp : $(date)"
    echo " List user logged now : [ ${userLoggedNow} ]"
    # get username of userTarget
    usernameTarget=`id -un $uidTarget`
    echo " Targeting... $usernameTarget"
    echo ""
    sleep 2

    users=(${userLoggedNow// / })
    for user in ${users[@]}
    do
        if [[ $user == $usernameTarget ]];
        then
            echo ""
            echo `sudo pkill -u $user`
            echo " !!>>> FOUND USER TARGET : $user"
            # echo `passwd -l $usernameTarget`
            echo " Login Disabled !"
            echo " Kicked !"
            echo ""
        fi
    done

done

