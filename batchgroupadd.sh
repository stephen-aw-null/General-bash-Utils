#!/bin/bash
# batchgroupadd.sh - Script to add groups in batch from a text file
# Parameter(s):
# $1 - text file from which groups will be read
# Exit Code(s):
# 0 - no group file specified
# 1 - specified group file could not be found
# 2 - Groups were added successfully


batchgroupadd () {
        if [ -z $1 ]; then
                echo 'No group file specified. Exiting...'
                exit 0
        elif [ ! -f $1 ]; then
                echo "File $1 not found. Exiting..."
                exit 1
        fi

        group_names=$(awk -F ':' '{ print $1 }' $1)
        # Functionality to add groups with specified GIDs not yet implemented
        #group_identifiers=$(awk -F ':' '{ print $2 }' $1)

        for group in $group_names; do
                groupadd $group
        done

        echo -e "All groups added successfully.\nAdded groups:\n$group_names"
        exit 2
}

batchgroupadd $1
