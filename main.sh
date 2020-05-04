#!/bin/bash

initial_setup=true
deploy_server=true
external_storage_mount=true
activate_watchdog=true

if [ "$initial_setup" = true ] ; then
    echo
    echo Executing Initial Setup
    chmod +x initial-pi-setup.sh
    sh initial-pi-setup.sh
fi

if [ "$deploy_server" = true ] ; then
    echo
    echo Deploying K3S Kubernetes Server
    chmod +x deploy-server.sh
    sh deploy-server.sh
fi

if [ "$external_storage_mount" = true ] ; then
    echo
    echo Mounting External Storage
    chmod +x external-storage-mount.sh
    sh external-storage-mount.sh
fi

if [ "$activate_watchdog" = true ] ; then
    echo
    echo Activating Watchdog
    chmod +x watchdog.sh
    sh watchdog.sh
fi

