#!/bin/bash

kubectl create namespace automation

kubectl apply -f automation.persistentvolume.yaml
kubectl apply -f automation.persistentvolumeclaim.yaml

kubectl apply -f automation.ingress.yaml -n automation

kubectl apply -f automation.home-assistant.deployment.yaml -n automation
kubectl apply -f automation.home-assistant.service.yaml -n automation