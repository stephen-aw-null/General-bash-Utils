#!/bin/bash
# batch_pw_reset.sh - Script to reset several passwords at once
# Parameter(s):
# $1 - File from which users will be read
# Exit Code(s):
# 0 - No user file was specified
# 1 - All user accounts were successfully reset
# 2 - The script was not run as root

batch_pw_reset() {
        # Verify that the script was run as root
        [ ! $USER == "root" ] && echo "$0: Please rerun the script as the root user." && exit 2

        # Verify that a user file was specified
        [ -z $1 ] && echo "$0: No user file specified. Exiting..." && exit 0

        # Parse the user file and reset each account in it
        users=$(awk '{ print $1 }' $1)
        for user in $users; do
                passwd -e $user
                passwd -u $user
                passwd -n 14 $user
                passwd -x 120 $user
                passwd -w 14 $user
        done>/dev/null

        echo "All user accounts successfully reset." && exit 1
}

batch_pw_reset $1
