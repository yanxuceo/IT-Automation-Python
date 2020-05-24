#!/usr/bin/env bash

# This script creates a new user on the local system
# You will be prompted to enter a username(login), the person name, and a password
# These information will be displayed

# make sure the script is being executed with superuser privilege
if [[ ${UID} -ne 0 ]]
then
  echo "Please run with sudo or as root."
  exit 1
fi

# get the username(login)， check if the username already exists
UserNameListlength=$(cut -d: -f1 /etc/passwd | wc -l)
while true
do
  cnt=0
  read -p "Enter the username to create: " USER_NAME

  for item in $(cut -d: -f1 /etc/passwd)
  do
    if [[ ${USER_NAME} != ${item} ]]
    then
      let cnt=cnt+1
    fi
  done
  # echo "Counting number is: ${cnt}"
  # echo "Actual length is: ${UserNameListlength}"
  if [[ ${cnt} -eq ${UserNameListlength} ]]
  then
    break
  else
    echo "Username already exists! Try again~"
  fi
done

# Get the real name (contents for the description field.).
read -p "Enter the name of the person or application that will be using the account: " CONMMENT

# Get the password
read  -p "Enter the password to use for the account: " PASSWORD

# Create the account -m: home_directory  -c: real name
useradd -c "${COMMENT}" -m "${USER_NAME}"

# Check to see if the useradd command succeeded
if [[ "${?}" -ne 0 ]]
then
  echo "The account could not be created."
  exit 1
fi

# Set the PASSWORD, Note: Need to send the password twice!!
(echo $PASSWORD; echo $PASSWORD) | passwd $USER_NAME

if [[ "${?}" -ne 0 ]]
then
  echo "The password for the account could not be set."
  exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo
echo 'username:'
echo "${USER_NAME}"
echo
echo 'password'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"
exit 0
