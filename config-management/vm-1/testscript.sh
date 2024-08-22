#!/usr/bin/bash

ERROR="\e[31m"
SUCCESS="\e[32m"
WARNING="\e[33m"
RESET="\e[0m"

VERSION="v1.0"

usage(){
    echo -e "${SUCCESS}Usage: testscript [--option] ${RESET}"
    echo ""
    echo -e "${SUCCESS}Options:${RESET}"
    echo -e "${WARNING}-h, --help${RESET}    Show this help message and exit"
    echo -e "${WARNING}-v, --version${RESET} show the script version and exit"
    echo ""
    echo -e "${SUCCESS}Example:${RESET}"
    echo -e "${SUCCESS}testscript.sh -f /path/to/source /path/to/destination${RESET}"
}

while [[ "$1" != "" ]]; do
    case $1 in
        -h | --help)
	    usage
	    exit 0
	    ;;
        -v | --version)
	    echo -e "${WARNING}testscript.sh version $VERSION${RESET}"
	    exit 0
	    ;;
	 *)
	     echo -e "${ERROR}Failed: unknown error${RESET}"
	     exit 1
	     ;;
     esac
     shift
done


case `date +%a` in
    "Mon")
         BACKUP=./inventory/lab-$(date +%D | sed 's#/#-#g').backup
	 mkdir $BACKUP
	 ;;
    "Tue" | "Wed")
	 ORIGINAL=./inventory/lab
	 BACKUP=./inventory/lab-$(date +%D | sed 's#/#-#g').backup
	 echo -e "${WARNING}Creating backups ...${RESET}"
	 cp $ORIGINAL $BACKUP
	 ;;
    *)
	 BACKUP="None"
	 echo "${WARNING}No backups to be done ...${WARNING}"
	 ;;
esac

