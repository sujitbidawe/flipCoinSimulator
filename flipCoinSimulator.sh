#!/usr/local/bin/bash

HCount=0
TCount=0

HHCount=0
HTCount=0
THCount=0
TTCount=0

HHHCount=0
HHTCount=0
HTHCount=0
THHCount=0
HTTCount=0
THTCount=0
TTHCount=0
TTTCount=0

declare -A singletDict
declare -A doubletDict
declare -A tripletDict

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

# function for doublet coin flip
function triplet(){

for (( flipCount=1; flipCount<=repeatitions; flipCount++ ))
do
		flipOne="$( coinFlip $flipOut )"
		flipTwo="$( coinFlip $flipOut )"
		flipThree="$( coinFlip $flipOut )"

		if [[ "$flipOne" == "H" && "$flipTwo" == "H" && "$flipThree" == "H" ]]
		then
				tripletDict[flip$flipCount]=HHH
				(( HHHCount++ ))
		elif [[ "$flipOne" == "H" && "$flipTwo" == "H" && "$flipThree" == "T" ]]
		then
				tripletDict[flip$flipCount]=HHT
				(( HHTCount++ ))
		elif [[ "$flipOne" == "H" && "$flipTwo" == "T" && "$flipThree" == "H" ]]
		then
				tripletDict[flip$flipCount]=HTH
				(( HTHCount++ ))
		elif [[ "$flipOne" == "T" && "$flipTwo" == "H" && "$flipThree" == "H" ]]
		then
				tripletDict[flip$flipCount]=THH
				(( THHCount++ ))
		elif [[ "$flipOne" == "H" && "$flipTwo" == "T" && "$flipThree" == "T" ]]
		then
				tripletDict[flip$flipCount]=HTT
				(( HTTCount++ ))
		elif [[ "$flipOne" == "T" && "$flipTwo" == "H" && "$flipThree" == "T" ]]
		then
				tripletDict[flip$flipCount]=THT
				(( THTCount++ ))
		elif [[ "$flipOne" == "T" && "$flipTwo" == "T" && "$flipThree" == "H" ]]
		then
				tripletDict[flip$flipCount]=TTH
				(( TTHCount++ ))
		else
				tripletDict[flip$flipCount]=TTT
				(( TTTCount++ ))
		fi
done

HHHPercent=`echo "scale=2; ($HHHCount*100)/$repeatitions" | bc`
HHTPercent=`echo "scale=2; ($HHTCount*100)/$repeatitions" | bc`
HTHPercent=`echo "scale=2; ($HTHCount*100)/$repeatitions" | bc`
THHPercent=`echo "scale=2; ($THHCount*100)/$repeatitions" | bc`
HTTPercent=`echo "scale=2; ($HTTCount*100)/$repeatitions" | bc`
THTPercent=`echo "scale=2; ($THTCount*100)/$repeatitions" | bc`
TTHPercent=`echo "scale=2; ($TTHCount*100)/$repeatitions" | bc`
TTTPercent=`echo "scale=2; ($TTTCount*100)/$repeatitions" | bc`

}

singlet
doublet
triplet

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
echo ""

#loop to display triplet dictionary
echo "~~~~~displaying triplet~~~~~"
for key in "${!tripletDict[@]}"
do
		echo "$key": "${tripletDict[$key]}"
done
echo HHHPercent=$HHHPercent%
echo HHTPercent=$HHTPercent%
echo HTHPercent=$HTHPercent%
echo THHPercent=$THHPercent%
echo HTTPercent=$HTTPercent%
echo THTPercent=$THTPercent%
echo TTHPercent=$TTHPercent%
echo TTTPercent=$TTTPercent%
