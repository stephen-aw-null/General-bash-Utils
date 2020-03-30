#!/bin/bash
# pw_reset.sh - Reset an individual user's password
# Parameter(s):
# $1 - Account to reset
# Exit code(s):
# 0 - No user was specified
# 1 - Account was successfully reset
# 2 - Script was not run as root

pw_reset() {
        # Verify that the script is run as root
        [ ! $USER == "root" ] && echo "$0: Please rerun the script as the root user." && exit 2

        # Verify that a user is specified to the script
        [ -z $1 ] && echo "$0: No user specified. Exiting..." && exit 0

        # Reset the user's account password, unlock it, and set various other parameters
        passwd -e $1
        passwd -u $1
        passwd -n 14 $1
        passwd -x 120 $1
        passwd -w 14 $1

        echo "User account successfully reset." && exit 1
}

pw_reset $1
