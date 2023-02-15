#i/bin/bash

# Validate params/arguments
if [[ -z $1 ]]; 
then
    echo "Missing the argument(username) in position at 1, Try again!"
    echo ""
    exit
fi
usernameTarget=$1


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


# Get UID from username target
# ..Not use username for tracking 
# ..Because he can change in short time
uidTarget=`id -u $usernameTarget`
if [[ -z "$uidTarget" ]]; 
then
    exit
fi


echo " START DETECTING..."
echo ""
echo " TARGET > UID: $uidTarget / user: $usernameTarget"


while true;
do
    
    # Get username of userTarget
    usernameTarget=`id -un $uidTarget`
    echo ""
    echo " Targeting... > $usernameTarget"
    
    # Get list users(username) login in server now 
    userLoggedNow=`users`
    echo " Timestamp : $(date)"
    echo " List user logged now : [ ${userLoggedNow} ]"
        
    # split string by 1 space "user1 user2" -> ["user1", "user2"]
    users=(${userLoggedNow// / })
    for user in ${users[@]}
    do
        # If some user login now is equal target
        if [[ $user == $usernameTarget ]];
        then
            echo ""
            echo "-----------------------------------------------------"
            echo ""
            echo " !! -------- FOUND USER TARGET : $user"
            echo " !! -------- LOGIN ON : $(date)"
            echo ""
            
            echo `sudo passwd -l $usernameTarget`
            echo "DISABLE LOGIN & KICKED OFF SERVER - DONE!"
            echo `sudo pkill -u $user`  # process kill all
            echo "-----------------------------------------------------"
        fi
    done

    sleep 2  # on production should be 10s

done

