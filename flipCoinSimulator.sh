#!/usr/local/bin/bash

heads=0
tails=0
totalFlips=0

declare -A flipDict

read -p "how many times do you want to flip the coin: " repeatitions

# loop to generte multiple singlet coin flip output
for (( flipCount=1; flipCount<=repeatitions; flipCount++ ))
do
		randOut=$(( RANDOM%2 ))

		if [[ $randOut -eq 0 ]]
		then
				(( heads++ ))
				flipDict[flip$flipCount]="H"
		else
				(( tails++ ))
				flipDict[flip$flipCount]="T"
		fi
done

#loop to display flip number and its output 
for key in "${!flipDict[@]}"
do
		echo "$key": "${flipDict[$key]}"
done

headsPercent=`echo "scale=2; ($heads/($repeatitions))*100" | bc`
tailsPercent=`echo "scale=2; ($tails/($repeatitions))*100" | bc`

echo "percentage of singlet heads: $headsPercent"
echo "percentage of singlet tails: $tailsPercent"
