#!/bin/bash
# batchuseradd.sh - script to add multiple users from a batch file
# Parameter(s):
# $1 - file from which the script will add users
# $2 - file from which the script will add user passwords
# Exit Code(s):
# 1 - No batch file specified
# 2 - No password file specified

batchuseradd () {
        if [ -z $1 ]
        then
                echo 'No batch file specified. Exiting...'
                exit 1
        elif [ -z $2 ]
        then
                echo 'No password file specified. Exiting...'
                exit 2
        else
                newusers $1
                # Add passwords for each user from the specified batch file
                # Note: passwords are encrypted with a SHA512 hash by default
                # Format: user_name:password
                chpasswd -c SHA512 < $2
        fi

        # Read the batch file to select the user names
        bulkNames=`cut -f1 -d: $1`
        bulkGID=`cut -f4 -d: $1`

        # For each new user, copy the contents of /etc/skel to the home directory, then change
        # the permissions and ownership of each item
        for NAME in ${bulkNames}
        do
                cp -R /etc/skel/* /home/$NAME
                chmod -R 750 /home/$NAME
                chown -R $NAME:$bulkGID /home/$NAME
        done
}

batchuseradd $1 $2
