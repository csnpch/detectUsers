#i/bin/bash

# Validate permision for use this script
permision_groups_check=`groups`
if [[ `echo $permision_groups_check | grep -c "wheel"` -gt 0 
|| `echo $permision_groups_check | grep -c "root"` -gt 0 ]];
then 
    # Allow permision sudo/root for commands
    echo `sudo -v`
else
    echo "Your permission can't not run this script"
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
# ..Not use username for tracking 
# ..Because he can change in short time
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

    # Get list users(username) login in server now 
    userLoggedNow=`users`
    echo ""
    echo " Timestamp : $(date)"
    echo " List user logged now : [ ${userLoggedNow} ]"
    
    # Get username of userTarget
    usernameTarget=`id -un $uidTarget`
    echo " Targeting... > $usernameTarget <"
    sleep 2

    users=(${userLoggedNow// / })
    for user in ${users[@]}
    do
        if [[ $user == $usernameTarget ]];
        then
            echo ""
            echo " !! -------- FOUND USER TARGET : $user"
            echo " !! -------- LOGIN ON : $(date)"
            echo ""
            
            echo " LOGIN IS DISABLE - DONE!"
            echo `passwd -l $usernameTarget`
            
            echo " KICKED OFF SERVER - DONE!"
            echo `sudo pkill -u $user`  # process kill all
        fi
    done

done

