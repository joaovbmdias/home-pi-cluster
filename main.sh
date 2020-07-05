#!/bin/bash

### PARAMETERS ###

#main
initial_setup=true
deploy_server=true
external_storage_mount=true
activate_watchdog=true

#initial setup
new_password=raspberry3
user=pi
new_hostname=raspberry3
new_ip=192.168.1.200
new_dns=192.168.1.250

#deploy server
master_node=true
master_node_ip=192.168.1.250
master_access_token=
install_helm=true
add_helm_repository_stable=true
add_helm_repository_jetstack=true

#external storage mount
mount_nas=true
nas_path="//192.168.1.202/public/Shared\\\040Videos"
nas_server_path="/home/pi/NAS"
nas_credentials_path="/etc/.NAScredentials"
nas_user=pi
kube_user=pi
nas_password="HGBtPL6BW;oc6J.G#Ew7w6iygCUrj.Tb"
mount_usb=false

if [ "$initial_setup" = true ] ; then
    echo
    echo Executing Initial Setup
    chmod +x initial-pi-setup.sh
    sh initial-pi-setup.sh $new_password $user $new_hostname $new_ip $new_dns
fi

if [ "$deploy_server" = true ] ; then
    echo
    echo Deploying K3S Kubernetes Server
    chmod +x k3s_server/deploy-server.sh 
    sh k3s_server/deploy-server.sh $master_node $master_node_ip $master_access_token $install_helm $add_helm_repository_stable $add_helm_repository_jetstack
fi

if [ "$external_storage_mount" = true ] ; then
    echo
    echo Mounting External Storage
    chmod +x external-storage-mount.sh
    sh external-storage-mount.sh $mount_nas $nas_path $nas_server_path $nas_credentials_path $nas_user $kube_user $nas_password $mount_usb
fi

if [ "$activate_watchdog" = true ] ; then
    echo
    echo Activating Watchdog
    chmod +x watchdog.sh
    sh watchdog.sh
fi