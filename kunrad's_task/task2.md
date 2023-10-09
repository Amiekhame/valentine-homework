#!/bin/bash

#1. Request a single letter as input
letter=$1
if [ -z "$letter" ]; then
  read -p "Enter a letter: " letter
fi

#2. Search the countries.txt file for lines that start with the input letter (case-insensitive)
# and use awk to display the second and third fields of the matching lines
Find_Country(){
  grep -i "^$letter" countries.txt | awk '{print $1 "/" $2}'
}

# #3. function to find just the country with the letter
# Find_just_Country(){
#   grep -i "^$letter" countries.txt | awk '{print $1}'
# }

# if [[ $(Find_just_Country) ]]; then
#     echo "$(Find_just_Country)"
#     exit 0
# fi

#4. Check if the input letter is valid
if [[ $letter =~ ^[A-Za-z]$ ]]; then

#5. Check if the country exists and print country and capital
  if [[ $(Find_Country) ]]; then
    echo "$(Find_Country)"
    exit 0
  else
    echo "Country that begins with $letter does not exist"
    exit 1
  fi
else
  echo "Invalid input. Please enter a single letter."
  exit 1
fi