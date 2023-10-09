#!/bin/bash

# # Get the mount point or file system from the user
# read -p "Enter the mount point or file system: " mount_point

# # Check if the mount point or file system is mounted
# if mountpoint -q "$mount_point"; then
#     # If it is mounted, get the used and free space
#     df -h "$mount_point" | awk 'NR==2 {print "Used: " $3 ", Free: " $4}'
# else
#     # If it is not mounted, return an error message
#     echo "Error: $mount_point is not mounted"
# fi


#1. Get the mount point or file system from the user
read -p "Enter the mount point or file system: " mount_point

#2. Check if the mount point or file system is mounted
if mount | grep -q "$mount_point"; then

#3. If it is mounted, get the used and free space
    df -h "$mount_point" | awk 'NR==2 {print "Used: " $3 ", Free: " $4}'
else

#4. If it is not mounted, return an error message
    echo "Error: $mount_point is not mounted"
fi