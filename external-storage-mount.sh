#!/bin/bash

mount_nas=true
nas_path="//192.168.1.202/public/Shared\\\040Videos"
nas_server_path="/home/pi/NAS"
nas_credentials_path="/etc/.NAScredentials"
nas_user=pi
kube_user=pi
nas_password="HGBtPL6BW;oc6J.G#Ew7w6iygCUrj.Tb"

mount_usb=false

##Mount NAS
if [ $mount_nas = true ] ; then
    echo Mounting NAS Drive
    mkdir -p $nas_server_path

    if [ -f $nas_credentials_path ]; then
        rm $nas_credentials_path
    fi

    echo 'username='"$nas_user" >> $nas_credentials_path
    echo 'password='"$nas_password" >> $nas_credentials_path

    grep -q $nas_server_path /etc/fstab
    if [ $? != 0 ]; then
        echo $nas_path $nas_server_path 'cifs credentials=/etc/.NAScredentials,uid=1000,gid=1000 0 0' >> /etc/fstab
    fi

    mount -a
    chown -R $kube_user:$kube_user $nas_server_path
fi

##Mount USB Storage
if [ $mount_usb = true ] ; then
    echo Mounting USB Drive
fi
