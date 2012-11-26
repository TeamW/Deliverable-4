#!/bin/bash

options=("Company" "Course Coordinator" "Student" "Quit")
compopt=("Add new advertisement" "Amend advertisement" "Quit")
studopt=("View advertisements" "Declare placement success" "Quit")
cocoopt=("View pending advertisements" "View new student declarations" "Quit")
addopt=("Accept" "Decline" "Postpone")
usropt=("Next advertisement" "Quit")

function addAdvert {
    echo "Add the text of your advertisement here"
    echo "When finised please type CTRL+d on a new line:
"
    touch $adno.sesp
    while read line
    do
	echo $line>>$adno.sesp
    done
    mv $adno.sesp .sesppend/
    adno=$((adno+1))
    echo $adno>.sesp.conf
}

function company {
    echo "You are a company."
    PS3="What do you wish to do, Company? "
    while(true) do
    select opt in "${compopt[@]}"
    do
	case $opt in
	    "Add new advertisement")
		clear
		addAdvert
		clear
		echo Advert added successfully.
		break;;
	    "Amend advertisement")
		clear
		echo "This is a stub. Functionality of amending an advertisement will go here"
		break;;
	    "Quit")
		clear
		echo "Logged out Company"
		PS3="Who are you? "
		return;;
	    *)
		clear
		echo "Sorry, this command was not recognised"
		break;;
	esac
    done
    done
}

function courseCoordinator {
    echo "You are a Course Coordinator."
    PS3="What do you wish to do, Course Coordinator? "
    while(true) do
	quickView
    select opt in "${cocoopt[@]}"
    do
	case $opt in
	    "View pending advertisements")
		clear
        pendingAdvertisements
		break;;
	    "View new student declarations")
		clear
		echo "This is a stub. Functionality of viewing new student declarations will go here."
		break;;
	    "Quit")
		clear
		echo "Logged out Course Coordinator"
		PS3="Who are you? "
		return;;
	    *)
		clear
		echo "Sorry, this command was not recognised"
		break;;
	esac
    done
    done
}

function student {
    echo "You are a student."
    PS3="What do you wish to do, Student? "
    while(true) do
    select opt in "${studopt[@]}"
    do
	case $opt in
	    "View advertisements")
		clear
		viewAdvertisements
		break;;
	    "Declare placement success")
		clear
		echo "This is a stub. Functionality of viewing new student declarations will go here."
		break;;
	    "Quit")
		clear
		echo "Logged out Student"
		PS3="Who are you? "
		return;;
	    *)
		clear
		echo "Sorry, this command was not recognised"
		break;;
	esac
    done
    done

}

function viewAdvertisements {
	fileList=""
	for file in $(ls .sespadv/)
	do
		fileList="$fileList .sespadv/$file"
	done
	array=($fileList)
	size=${#array[@]}
	if [ $size -eq 0 ] 
		then
		echo "Sorry, there are no advertisements to view at this time"
	fi
	for file in ${array[*]}
	do
		while read line; do
			echo "$line"
		done < $file
		echo '
Do you want to apply for this? If so, please contact the company.
'
		select opt in "${usropt[@]}"
		do
		case $opt in
			"Next advertisement")
				clear
				break;;
			"Quit")
				clear
				return;;
			*)
			echo "Sorry, this command was not recognised"
		esac
		done
	done
}

function pendingAdvertisements {
	for file in $(ls .sesppend/)
	do
		while read line; do
			echo "$line"
		done < ".sesppend/$file"
		echo
		select opt in "${addopt[@]}"
		do
		case $opt in
			"Accept")
			mv ".sesppend/$file" ".sespadv/$file"
			break;;
			"Decline")
			mv ".sesppend/$file" ".sespdecl/$file"
			clear
			break;;
			"Postpone")
			clear
			break;;
			*)
			echo "Sorry, your option is unrecognised."
			break;;
		esac
		done
	done
	clear
	echo "All advertisements dealt with."
}

function quickView {
	pendcount=`ls .sesppend | wc -l`
	livecount=`ls .sespadv | wc -l`
	refcount=`ls .sespdecl | wc -l`
	echo "
Today at a glance
-----------------"
	echo "Pending advertisements: $pendcount"
	echo "Live advertisements: $livecount"
	echo "Refused Advertisements: $refcount
"
}

clear
for line in $(cat .sesp.conf)
do
adno=$line
done
echo "Welcome to the system, please log in."
PS3="Who are you? "
while(true) do
select opt in "${options[@]}"
do
    case $opt in
	"Company")
	    clear
	    company
	    break;;
	"Course Coordinator")
	    clear
	    courseCoordinator
	    break;;
	"Student")
	    clear
	    student
	    break;;
	"Quit")
	    clear
	    exit;;
	*)
	    echo "Sorry this command was not recognised."
	    break;;
    esac
done
done
