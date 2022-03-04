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
   airflow users create \
    --username $iuser \
    --password $ipasswd \
    --firstname $iuser \
    --lastname datalabs \
    --role User \
    --email $iuser@gmail.com

done
# Return the original field separator
IFS=$ORIGINAL_IFS