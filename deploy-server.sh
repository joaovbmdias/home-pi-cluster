##IF MASTER

ECHO defining K3S variables
export K3S_KUBECONFIG_MODE="644"
export INSTALL_K3S_EXEC=" --no-deploy servicelb --no-deploy traefik"

ECHO installing k3s master
curl -sfL https://get.k3s.io | sh -

ECHO saving master access token
sudo cat /var/lib/rancher/k3s/server/node-token

##IF NODE
ECHO defining K3S variables
export K3S_KUBECONFIG_MODE="644"
export K3S_URL="https://###.###.###.###:6443" #server ip
export K3S_TOKEN="MASTER_ACCESS_TOKEN"

ECHO installing k3s node
curl -sfL https://get.k3s.io | sh -


##HELM HELM HELM

##first download from github
tar -zxvf helm-v3.<X>.<Y>-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm

##Add Repositories
helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm repo add jetstack https://charts.jetstack.io

helm repo update