#!/bin/bash
###############################################################################################
###############################################################################################
###############################################################################################
######          This script will help to convert the Microsoft outlook PST file      ##########
######                    into Thunderbird/Evolution compatible format               ##########
######                                                                               ##########
###############################################################################################
###############################################################################################
###############################################################################################   

#check user
if [ "$USER" = 'root' ]
    then
        echo "User check passed"
    else        gdialog --title "User Check" --msgbox "User is not Root. Please run the script as root user." 200 150
        echo "User is not Root. Please run the script as root user."
        exit 1
fi

#OS check
cat /etc/debian_version > /dev/null
if [ $? != 0 ]; then

gdialog --title "OS check" --msgbox "You are not using Debian/Ubuntu, Install readpst package from http://www.five-ten-sg.com/libpst/rn01re01.html" 200 150

else

readpst -V > /dev/null
          if [ $? != 0 ]; then

    apt-get update
    apt-get -y install readpst
    fi
fi

mkdir    ~/home/outlook

#File selection
readpst  -o  ~/home/outlook  -r  `zenity --file-selection`

find ~/home/outlook -type d | tac | grep -v '^~/home/outlook$' | xargs -d '\n' -I{} mv {} {}.sbd

find ~/home/outlook.sbd -name mbox -type f | xargs -d '\n' -I{} echo '"{}" "{}"' | sed -e 's/\.sbd\/mbox"$/"/' | xargs -L 1 mv


#Script Completion
find ~/home/outlook.sbd -empty -type d | xargs -d '\n' rmdir
gdialog --title "Pst Conversion complete" --msgbox "Your pst conversion is complete,just paste the folder ~/home/outlook.sbd in Local Folder in Thunderbird/Evolution and you can use the folders there" 200 150
