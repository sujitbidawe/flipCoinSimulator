#!/usr/local/bin/bash

HCount=0
TCount=0
HHCount=0
HTCount=0
THCount=0
TTCount=0

declare -A singletDict
declare -A doubletDict

read -p "how many times do you want to flip the coin: " repeatitions

# function to flip the coin
function coinFlip() {

		if [[ $(( RANDOM%2 )) -eq 0 ]]
		then
				flipOut=H
		else
				flipOut=T
		fi
echo $flipOut
}

# function for singlet coin flip
function singlet(){
for (( flipCount=1; flipCount<=repeatitions; flipCount++ ))
do
		flipOut="$( coinFlip $flipOut )"
		if [[ "$flipOut" == "H" ]]
		then
				singletDict[flip$flipCount]=H
				(( HCount++ ))
		else
				singletDict[flip$flipCount]=T
				(( TCount++ ))
		fi
done

HPercent=`echo "scale=2; ($HCount*100)/$repeatitions" | bc`
TPercent=`echo "scale=2; ($TCount*100)/$repeatitions" | bc`

#HPercent=$(( (HCount*100)/repeatitions ))
}

# function for doublet coin flip
function doublet(){

for (( flipCount=1; flipCount<=repeatitions; flipCount++ ))
do
		flipOne="$( coinFlip $flipOut )"
		flipTwo="$( coinFlip $flipOut )"

		if [[ "$flipOne" == "H" && "$flipTwo" == "H" ]]
		then
				doubletDict[flip$flipCount]=HH
				(( HHCount++ ))
		elif [[ "$flipOne" == "H" && "$flipTwo" == "T" ]]
		then
				doubletDict[flip$flipCount]=HT
				(( HTCount++ ))
		elif [[ "$flipOne" == "T" && "$flipTwo" == "H" ]]
		then
				doubletDict[flip$flipCount]=TH
				(( THCount++ ))
		else
				doubletDict[flip$flipCount]=TT
				(( TTCount++ ))
		fi
done

HHPercent=`echo "scale=2; ($HHCount*100)/$repeatitions" | bc`
HTPercent=`echo "scale=2; ($HTCount*100)/$repeatitions" | bc`
THPercent=`echo "scale=2; ($THCount*100)/$repeatitions" | bc`
TTPercent=`echo "scale=2; ($TTCount*100)/$repeatitions" | bc`

}

singlet
doublet

#loop to display singlet dictionary 
echo "~~~~~displaying singlet~~~~~"
for key in "${!singletDict[@]}"
do
		echo "$key": "${singletDict[$key]}"
done
echo HPercent=$HPercent%
echo TPercent=$TPercent%
echo ""

#loop to display doublet dictionary
echo "~~~~~displaying doublet~~~~~"
for key in "${!doubletDict[@]}"
do
		echo "$key": "${doubletDict[$key]}"
done
echo HHPercent=$HHPercent%
echo HTPercent=$HTPercent%
echo THPercent=$THPercent%
echo TTPercent=$TTPercent%

