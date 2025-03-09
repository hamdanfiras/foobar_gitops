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


kubectl port-forward svc/argocd-server -n argocd 8086:443 &> /dev/null &

password=$(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d)
echo "ArgoCD initial admin password: $password"

sleep 2

argocd login "localhost:8086" --username admin --password $password --insecure 

argocd repo add https://github.com/hamdanfiras/foobar_gitops --username hamdanfiras --password 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

kubectl apply -f ./apps/root-dev.yml


exit 0

# after

# kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d && echo


kubectl port-forward svc/argocd-server -n argocd 8086:443 &

password=$(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d)
echo "ArgoCD initial admin password: $password"



argocd login {argocd_server} --username admin --password @password



kubectl port-forward svc/argocd-server -n argocd 8086:443


gcloud container clusters describe foobar --zone $region --format="value(endpoint)"
