#!/bin/bash
function company {
	echo "You are a company."
}
function courseCoordinator {
	echo "You are a course coordinator."
}
function student {
	echo "You are a student."
}
PS3="Who are you? "
options=("Company" "Course Coordinator" "Student" "Quit")
select opt in "${options[@]}"
do
	case $opt in
	"Company")
		company;;
	"Course Coordinator")
		courseCoordinator;;
	"Student")
		student;;
	"Quit")
		exit;;
	*)
		echo "You are an alien.";;
	esac
done
