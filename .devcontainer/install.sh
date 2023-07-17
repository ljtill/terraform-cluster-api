#!/bin/sh

# kubernetes/kubectl
echo "Download: kubectl"
curl -Lo ./kubectl https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl && sudo chown root:root ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl

# flux
echo "Download: flux"
version=$(curl -sL https://api.github.com/repos/fluxcd/flux2/releases/latest | jq -r ".tag_name" | sed 's/v//')
curl -Lo ./flux_"$version"_linux_amd64.tar.gz https://github.com/fluxcd/flux2/releases/download/v"$version"/flux_"$version"_linux_amd64.tar.gz
tar -zxof ./flux_"$version"_linux_amd64.tar.gz && rm -f ./flux_"$version"_linux_amd64.tar.gz
chmod +x ./flux && sudo chown root:root ./flux && sudo mv ./flux /usr/local/bin/flux

# helm
echo "Download: helm"
version=$(curl -sL https://api.github.com/repos/helm/helm/releases/latest | jq -r ".tag_name" | sed 's/v//')
curl -Lo ./helm-v"$version"-linux-amd64.tar.gz https://get.helm.sh/helm-v"$version"-linux-amd64.tar.gz
tar -zxof ./helm-v"$version"-linux-amd64.tar.gz && rm -f ./helm-v"$version"-linux-amd64.tar.gz
chmod +x ./linux-amd64/helm && sudo chown root:root ./linux-amd64/helm && sudo mv ./linux-amd64/helm /usr/local/bin/helm
rm -rf ./linux-amd64

# kubernetes-sigs/cluster-api
echo "Download: clusterctl"
version=$(curl -sL https://api.github.com/repos/kubernetes-sigs/cluster-api/releases/latest | jq -r ".tag_name" | sed 's/v//')
curl -Lo ./clusterctl https://github.com/kubernetes-sigs/cluster-api/releases/download/v"$version"/clusterctl-linux-amd64
chmod +x ./clusterctl && sudo chown root:root ./clusterctl && sudo mv ./clusterctl /usr/local/bin/clusterctl
