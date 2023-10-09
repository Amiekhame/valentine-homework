#!/bin/bash
# This script accepts a directory path as an argument and prints the full path of each file in that directory.

#1. Get the directory path from the user.
dir_path=$1
read -p "Input directory path: " dir_path
#2. Get the sort order from the user.
sort_order=$2
read -p "Sort order: " sort_order
#this can either be "a" for ascending or "d" for descending.

#3. Check if the directory path is valid.
if [ ! -d "$dir_path" ]; then
  echo "Error: The directory path '$dir_path' is not valid."
  exit 1
fi

#4. Get the full path of each file in the directory.
files=$(find "$dir_path" -type f)

#5. Sort the files in the specified order.
if [ "$sort_order" == "a" ]; then
  files=$(ls $files)
elif [ "$sort_order" == "d" ]; then
  files=$(ls -r $files)
fi

# Print the full path of each file.
echo "Contents of $dir_path:"
for file in $files; do
  echo "$file"
done