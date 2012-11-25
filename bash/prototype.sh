#!/bin/bash

options=("Company" "Course Coordinator" "Student" "Quit")
compopt=("Add new advertisement" "Amend application" "Quit")
studopt=("View advertisements" "Declare placement success" "Quit")
cocoopt=("View pending advertisements" "View new student declarations" "Quit")
addopt=("Accept" "Decline")
advert=""

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
	    "Amend application")
		clear
		echo "This is where you can amend shit"
		break;;
	    "Quit")
		clear
		echo "Logged out Company"
		PS3="Who are you? "
		return;;
	    *)
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
    select opt in "${cocoopt[@]}"
    do
	case $opt in
	    "View pending advertisements")
		clear
        pendingAdvertisements
		break;;
	    "View new student declarations")
		clear
		echo "This is where you can see shithot students"
		break;;
	    "Quit")
		clear
		echo "Logged out Course Coordinator"
		PS3="Who are you? "
		return;;
	    *)
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
		echo "This is where you can view shit"
		break;;
	    "Declare placement success")
		clear
		echo "This is where you can say you're shithot"
		break;;
	    "Quit")
		clear
		echo "Logged out Student"
		PS3="Who are you? "
		return;;
	    *)
		echo "Sorry, this command was not recognised"
		break;;
	esac
    done
    done

}
function pendingAdvertisements {
	for file in $(ls .sesppend)
	do
		while read line; do
			echo "$line"
		done < ".sesppend/$file"
		select opt in "${addopt[@]}"
		do
		case $opt in
			"Accept")
			clear
			mv ".sesppend/$file" ".sespadv/$file"
			break;;
			"Decline")
			echo "will probably delete"
			break;;
			*)
			echo "stupid user"
			break;;
		esac
		done
	done
}
clear
for line in $(cat .sesp.conf)
do
adno=$line
echo $adno
done<.sesp.conf
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
