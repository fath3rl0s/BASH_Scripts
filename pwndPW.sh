#!/bin/bash
#Carlos Enamorado

#Query Have You Been Pwned API for password integrity


# Usage:
# 1 ./pwndPW
# 2 Prompt user for input as a security measure
# 3 <password> Password to Check - Silently read and store user input; STDIN
# 
# Adds warning and directions if user passes an argument with the execution
# Adds warning and exit if user inputs empty string
# Prints usage

if [ "$1" == "-h" ]
then
	printf 'Usage: ./pwndPW + Enter\n'
	echo
	printf 'Keep in mind\n'
	printf 'Passing an argument in cleartext poses a security risk\n'
	printf 'The password may be stored in the bash history if so'
	exit 0
fi

if [ "$#" -ne 0 ]
then
	printf 'Error, please do not use password as an argument\n'
	echo
	printf 'See Usage by using -h:\n'
	printf './pwndPW -h'
	exit 0
fi

if (( "$#" == 0 ))
then
	printf 'Enter your password: '
	read -s userPass
	echo
else
	printf "For security purposes, please do not give your password as an argument\n"
	echo "**************************************************************************"
	printf "Usage: ./pwndPW\nThen hit ENTER to disretely enter password\n"
	printf "See bash history for cleartext security risk"
	exit 0
fi

if [ -z "$userPass" ]
then
	printf 'Empty password not allowed\n'
	printf 'Try Again'
	exit 0
fi

userPass=$(echo -n "$userPass" | sha1sum)
userPass=${userPass:0:40}
firstFive=${userPass:0:5}
ending=${userPass:5}
pwned=$(curl -s "https://api.pwnedpasswords.com/range/$firstFive" | \
	tr -d '\r' | grep -i "$ending")
passwordFound=${pwned##*:}


if [ -n "$passwordFound" ] && [ "$passwordFound" -gt 0 ]
then 
	printf 'Password is PWND %d Times!\n' "$passwordFound"
	printf 'Recommend changing your password'
	exit 0
else
	printf 'Your password has not yet been breached'
	exit 1
fi
