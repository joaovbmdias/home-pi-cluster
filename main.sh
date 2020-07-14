#!/bin/bash

### PARAMETERS ###

#main
initial_setup=true
deploy_server=true
external_storage_mount=true
activate_watchdog=true

#initial setup
new_password=<SOMEPASSWORD>
user=pi
new_hostname=<SOMEHOSTNAME>
new_ip=<SOMEIP>
new_dns=<SOMEIP>

#deploy server
master_node=true
master_node_ip=<SOMEIP>
master_access_token=
install_helm=true
add_helm_repository_stable=true
add_helm_repository_jetstack=true

#external storage mount
mount_nas=true
nas_path=<SOMEPATH>
nas_server_path=<SOMEPATH>
nas_credentials_path=<SOMEPATH>
nas_user=<SOMEUSER>
kube_user=<SOMEUSER>
nas_password=<SOMEPASSWORD>
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