#!/bin/bash
#Author GS
#Program to create full VM
clear
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    printf "Only root user can run this program!, Sorry"
    exit
fi
if [ $# -ne 2 ]; then
    printf "\n"
    printf "Format of the command is : exportvm name_of_current_vm  name_of_exporting_vm \n"
    printf "Retry with above command with correct syntax ! \n"
    exit 1
fi
printf "\n"
printf "===================================================================================\n"
printf "#\n"
printf "#  Export VM Job Started..........Do not cancell it to avoid corruption .. \n"
printf "#\n"
printf "#  Note that Export of VM is a CPU & Disk Intensive Job ! \n"
printf "#  It will take several minutes to finish, depnding on file size \n"
printf "#  You need to calm.  Have a Coffee or Tea..\n"
printf "#  If everything goes well, you will have your exported vm \n"
printf "#\n"
printf "===================================================================================\n"
printf "\n"
printf "Trying to Export VM:$1 The outfile will be $2_exported_vm.img \n"

qemu-img convert -f qcow2 $1.img -O qcow2 $2_exported_vm.img  2> /dev/null & 
#  echo dots while command is executing
while ps |grep $! &>/dev/null; do
        echo -n "..."
        sleep 2
done
printf "\n"
if [ ! -f $PWD/$2_exported_vm.img  ]; then
    printf "Export to  New VM Failed,  Please contact Administrator! \n"
else
s=$( stat -c %s $PWD/$2_exported_vm.img)
    printf "Export is successful.  Exported vm [ $2_exported_vm.img Size:$s ] is now ready.\n"
    printf "\n"
    printf "Rename this file as you like and import it as 'Existing Disk' for your  new VM \n"
    printf "\n"
    printf "Thank you for using the program !!! \n"
    printf "\n"
fi
