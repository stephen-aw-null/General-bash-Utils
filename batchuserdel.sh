#!/bin/bash
# batchuserdel.sh - remove users from the system in batch
# Parameter(s):
# $1 - file with the users to be deleted
# $2 - delete user home directories; type yes to delete the directories or leave blank to preserve them
# Exit Code(s):
# 0 - No text file specified
# 1 - Script executed successfully

batchuserdel () {
        # If no text file is specified, exit
        if [ -z $1 ]; then
                echo "No user file specified. Exiting..."
                exit 0
        fi

        # Select the username(s) to be deleted
        user_list=`cut -f1 -d: $1`

        # Remove the users and their home directories
        for NAME in ${user_list}
        do
                userdel $NAME
                if [ $2 = "yes" ]
                then
                        rm -r /home/$NAME
                else
                        echo 'User home directories preserved.'
                fi
        done

        echo "All users specified in $1 have been removed successfully."
        exit 1
}

batchuserdel $1 $2
