#!/bin/bash

master_node=$1
master_node_ip=$2
master_access_token=$3

install_helm=$4
add_helm_repository_stable=$5
add_helm_repository_jetstack=$6

if [ "$master_node" = true ] ; then
    echo Deploying K3S Master Node

    export K3S_KUBECONFIG_MODE="644"
    export INSTALL_K3S_EXEC=" --no-deploy servicelb --no-deploy traefik"

    curl -sfL https://get.k3s.io | sh -

    echo K3S Master Node Access Token: $(cat /var/lib/rancher/k3s/server/node-token)
else
    echo Deploying K3S Slave Node

    export K3S_KUBECONFIG_MODE="644"
    export K3S_URL="https://${master_node_ip}:6443"
    export K3S_TOKEN="${master_access_token}"

    curl -sfL https://get.k3s.io | sh -
fi

if [ "$install_helm" = true ] ; then
    echo
    echo Deploying Helm Package Manager

    echo
    echo Downloading Helm
    wget https://get.helm.sh/helm-v3.1.3-linux-arm.tar.gz

    echo
    echo Installing
    tar -zxvf helm-v3.1.3-linux-arm.tar.gz
    mv linux-arm/helm /usr/local/bin/helm
    echo SUCCESS!

    if [ "$add_helm_repository_stable" = true ] ; then
        echo
        echo Adding Helm Google Stable Repository
        helm repo add stable https://kubernetes-charts.storage.googleapis.com
        echo SUCCESS!
    fi


    if [ "$add_helm_repository_stable" = true ] ; then
        echo
        echo Adding Helm Jetstack Repository
        helm repo add jetstack https://charts.jetstack.io
        echo SUCCESS!
    fi

    echo
    echo Updating Helm Repositories
    helm repo update
    echo SUCCESS!

    echo
    echo Removing Unnecessary files
    rm -r linux-arm
    rm helm-v3.1.3-linux-arm.tar.gz
fi