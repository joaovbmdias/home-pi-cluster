#!/bin/bash

kubectl create namespace automation

kubectl apply -f automation.persistentvolume.yaml -n automation
kubectl apply -f automation.persistentvolumeclaim.yaml -n automation

kubectl apply -f automation.ingress.yaml -n automation

kubectl apply -f home-assistant/deployment.yaml -n automation
kubectl apply -f home-assistant/service.yaml -n automation