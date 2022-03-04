#!/bin/bash
# Preserve the original field separator
ORIGINAL_IFS=$IFS
# Change the field separator to the new line character
IFS=$'\n'
# Read the lines with crednetials from the CSV file
read -d '' -ra credentials < ./credentials.csv
# Change the file separtor to a comma
IFS=','
# Iterate over the credentials
for credential in "${credentials[@]}"
do
   # Split the credentials into two separate variables
   read iuser ipasswd <<< "$credential"
   # Create the user
   mc admin user add minio $iuser $ipasswd
   mc admin group add minio minioaccess $iuser
   mc admin policy set minio readwrite user=$iuser

done
# Return the original field separator
IFS=$ORIGINAL_IFS