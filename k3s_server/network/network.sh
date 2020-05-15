#!/bin/bash

kubectl create namespace network

kubectl apply -f network.persistentvolume.yaml
kubectl apply -f network.persistentvolumeclaim.yaml

kubectl apply -f network.dnsserver.deployment.yaml -n network
kubectl apply -f network.dnsserver.service.yaml -n network

kubectl apply -f network.ingress.yaml -n network