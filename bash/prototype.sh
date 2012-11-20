#!/bin/bash

options=("Company" "Course Coordinator" "Student" "Quit")
compopt=("Add new advertisement" "Amend application" "Quit")
studopt=("View advertisements" "Declare placement success" "Quit")
cocoopt=("View pending advertisements" "View new student declarations" "Quit")

function company {
    echo "You are a company."
    number=$RANDOM
	fixednumber=$(($number%3))
    echo "here's a random number $fixednumber"
    PS3="What do you wish to do, Company? "
    while(true) do
    select opt in "${compopt[@]}"
    do 
	case $opt in
	    "Add new advertisement")
		clear
		echo "This is where you can add shit"
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
		echo "You are an alien"
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
		echo "This is where you can view pending shit"
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
		echo "You are an alien"
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
		echo "You are an alien"
		break;;
	esac
    done
    done

}
clear
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
	    echo "You are an alien."
	    break;;
    esac
done
done