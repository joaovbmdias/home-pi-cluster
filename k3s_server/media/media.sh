#!/bin/bash

kubectl create namespace media

kubectl apply -f media.persistentvolume.yaml
kubectl apply -f media.persistentvolumeclaim.yaml
kubectl apply -f media.persistentNAS.yaml
kubectl apply -f media.persistentNASclaim.yaml

kubectl apply -f media.ingress.yaml -n media

# kubectl create secret generic openvpn \
#     --from-literal username=<VPN_USERNAME> \
#     --from-literal password=<VPN_PASSWORD> \
#     --namespace media

helm install transmission bananaspliff/transmission-openvpn --values media.transmission.values.yaml -n media

helm install jackett bananaspliff/jackett --values media.jackett.values.yaml -n media
helm install sonarr bananaspliff/sonarr --values media.sonarr.values.yaml -n media
helm install radarr bananaspliff/radarr --values media.radarr.values.yaml -n media

kubectl apply -f media.jellyfin.deployment.yaml -n media
kubectl apply -f media.jellyfin.service.yaml -n media