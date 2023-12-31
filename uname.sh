#!/bin/bash
# Carlos Enamorado

# OS Detection
# Simple script to check OS: MS-Windows/Linux/MacOS
#


# Define the function DetectOS()

DetectOS()
{
	#the new variable 'uname' is = to the command output of uname
	uname=$(uname)
	#If Statement; square brackets indicate start of TRUE/FALSE statement
	if [ "$uname" = "Linux" ]; then
		OS=Linux
	elif [ "$uname" = "Darwin" ]; then
		OS=MacOS
	fi
}

# Call the Function to perform the check
DetectOS
echo "You are currently running $OS"
echo "============================="
