#!/bin/bash

mount_nas=true
nas_path="//192.168.1.202/public/Shared\\\040Videos"
nas_server_path="/home/pi/NAS"
nas_user=pi
nas_password="HGBtPL6BW;oc6J.G#Ew7w6iygCUrj.Tb"

mount_usb=false

##Mount NAS
if [ "$mount_nas" = true ] ; then
    echo Mounting NAS Drive
    mkdir -p $nas_server_path
    rm /etc/.NAScredentials
    echo 'username='"$nas_user" >> /etc/.NAScredentials
    echo 'password='"$nas_password" >> /etc/.NAScredentials
    echo $nas_path $nas_server_path 'cifs credentials=/etc/.NAScredentials,uid=1000,gid=1000 0 0' >> /etc/fstab

    mount -a

    chown -R pi:pi /home/pi/NAS
fi

##Mount USB Storage
if [ "$mount_usb" = true ] ; then
    echo Mounting USB Drive
fi