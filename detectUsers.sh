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
    
    # get username of userTaret
    usernameTarget=`id -un $uidTarget`
    echo " Targeting... user: $usernameTarget"

    userLoggedNow=`users`

    echo " List user logged now : [ ${userLoggedNow} ]"
    echo " Timestamp : $(date)"
    echo ""
    sleep 2

    users=(${userLoggedNow// / })
    for user in ${users[@]}
    do
        if [[ $user == $usernameTarget ]];
        then
            echo " !!>>> FOUND USER TARGET : $user"
            echo `ls -al`
        fi
    done

done

