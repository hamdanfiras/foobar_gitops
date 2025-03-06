#!/bin/bash

project="macro-shadow-452810-p9"
cluster="foobar"
region="us-central1"
zone="us-central1-a"

gcloud config set project $project
gcloud config set compute/zone $region
# gcloud beta container --project "$project" clusters create-auto "$cluster" --region "us-central1" --release-channel "regular" --tier "standard" --enable-ip-access --no-enable-google-cloud-access --network "projects/$project/global/networks/default" --subnetwork "projects/$project/regions/us-central1/subnetworks/default" --cluster-ipv4-cidr "/17" --binauthz-evaluation-mode=DISABLED
# gcloud container clusters create "$cluster" \
#   --project "$project" \
#   --region $region \
#   --release-channel "regular" \
#   --tier "standard" \
#   --enable-ip-access \
#   --no-enable-google-cloud-access \
#   --network "projects/$project/global/networks/default" \
#   --subnetwork "projects/$project/regions/us-central1/subnetworks/default" \
#   --cluster-ipv4-cidr "/17" \
#   --disk-size "100" \
#   --binauthz-evaluation-mode=DISABLED

gcloud container clusters create $cluster \
  --project "$project" \
  --zone $zone \
  --release-channel "regular" \
  --tier "standard" \
  --enable-ip-access \
  --no-enable-google-cloud-access \
  --network "projects/$project/global/networks/default" \
  --subnetwork "projects/$project/regions/us-central1/subnetworks/default" \
  --cluster-ipv4-cidr "/17" \
  --disk-size "100" \
  --binauthz-evaluation-mode=DISABLED


# gcloud container clusters create $cluster --zone $region
gcloud container clusters get-credentials $cluster

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

exit 0

# after

kubectl port-forward svc/argocd-server -n argocd 8086:443
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d && echo

gcloud container clusters describe foobar --zone $region --format="value(endpoint)"
