
#!/bin/bash
clear
clear
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    printf "Only root user can run this program!, Sorry"
    exit
fi
if [ $# -ne 2 ]; then

printf "\n"
printf "Format of the command:\033[1m  clone_create  full_path_of_template_file.img   vmname \033[0m \n"
printf "\n"
printf "Example:\033[1m clone_create template-dir\os-template.img  vm1 \033[0m \n"

printf "\n"
exit 1
fi

{
if [ ! -f $1 ]; then 

printf "\n"
printf "Error:\033[1m Template File Not Found !  Try with correct Template file name and path  \033[0m \n"
printf "\n"
exit 0
fi
}


cmd_disk=qemu-img
cmd_format='-f'
type_format=qcow2
backing_sw='-b'
if [ -f "$2-vm.img" ]
then
printf "\n"
printf "Error:\033[1m VM Image file already exists.  Try with other vmname \033[0m \n"
printf "\n"
exit 1
else

$cmd_disk create $cmd_format $type_format $backing_sw $1 $2-vm.img  >/dev/null 2>/dev/null
#clear
printf "\n"
printf "\033[1m $2-vm.img \033[0m file is ready which you can import to create VM"
printf "\n"
fi
exit 0
