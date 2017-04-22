#!/bin/bash
clear
clear
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    printf "Only root user can run this program!, Sorry"
    exit
fi
printf "\n"
printf "Format of the command: clone_create  full_path\template_file.img   vmname \n"
cmd_disk=qemu-img
cmd_format='-f'
type_format=qcow2
backing_switch='-b'
$cmd_disk create $cmd_format $type_format $backing_switch $1 $2-vm.img  2>/dev/null
clear
printf "\n"
printf "$2-vm.img file is ready which you can import to create VM"
printf "\n"
exit 0
