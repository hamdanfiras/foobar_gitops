#!/bin/bash

cluster="foobar"
region="us-central1"

gcloud config set project macro-shadow-452810-p9
gcloud config set compute/zone $region
gcloud beta container --project "macro-shadow-452810-p9" clusters create-auto "$cluster" --region "us-central1" --release-channel "regular" --tier "standard" --enable-ip-access --no-enable-google-cloud-access --network "projects/macro-shadow-452810-p9/global/networks/default" --subnetwork "projects/macro-shadow-452810-p9/regions/us-central1/subnetworks/default" --cluster-ipv4-cidr "/17" --binauthz-evaluation-mode=DISABLED
gcloud container clusters create $cluster --zone $region
gcloud container clusters get-credentials $cluster

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

exit 0

# after

kubectl port-forward svc/argocd-server -n argocd 8086:443
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d && echo

gcloud container clusters describe foobar --zone $region --format="value(endpoint)"
