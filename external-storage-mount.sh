#!/bin/bash

mount_nas=$1
nas_path=$2
nas_server_path=$3
nas_credentials_path=$4
nas_user=$5
kube_user=$6
nas_password=$7

mount_usb=$8

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
        echo $nas_path $nas_server_path 'cifs credentials=$nas_credentials_path,uid=1000,gid=1000 0 0' >> /etc/fstab
    fi

    mount -a
    chown -R $kube_user:$kube_user $nas_server_path
fi

##Mount USB Storage
if [ $mount_usb = true ] ; then
    echo Mounting USB Drive
fi
