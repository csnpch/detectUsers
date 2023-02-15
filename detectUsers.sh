#i/bin/bash

# Validate permision for use this script
permision_groups_check=`groups $1`
if [[ `echo $permision_groups_check | grep -c "wheel"` -gt 0 || `echo $permision_groups_check | grep -c "root"` -gt 0 ]];
then    
    :
else
    echo "Your permision can't not run this script"
    exit
fi

# Get params username or read
if [[ -z $1 ]]; 
then
    read -p "Input username for detect : " usernameTarget
else
    usernameTarget=$1
fi


# Get UID from username target
uidTarget=`id -u $usernameTarget`
if [[ -z "$uidTarget" ]]; 
then
    exit
fi


echo ""
echo " START DETECT..."
echo ""
echo " TARGET > UID: $uidTarget / user: $usernameTarget"


while true
do
    
    userLoggedNow=`users`
    echo ""
    echo " Timestamp : $(date)"
    echo " List user logged now : [ ${userLoggedNow} ]"
    # get username of userTarget
    usernameTarget=`id -un $uidTarget`
    echo " Targeting... > $usernameTarget <"
    sleep 2

    users=(${userLoggedNow// / })
    for user in ${users[@]}
    do
        if [[ $user == $usernameTarget ]];
        then
            echo ""
            echo `sudo pkill -u $user`
            echo " !! FOUND USER TARGET : $user"
            # echo `passwd -l $usernameTarget`
            echo " Login Disabled !"
            echo " Kicked !"
        fi
    done

done

