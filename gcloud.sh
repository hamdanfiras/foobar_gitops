gcloud config set project macro-shadow-452810-p9
gcloud config set compute/zone us-central1 
gcloud container clusters create autopilot-cluster-1 --zone us-central1 
gcloud container clusters get-credentials autopilot-cluster-1

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

exit 0

# after

kubectl port-forward svc/argocd-server -n argocd 8086:443
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d && echo

gcloud container clusters describe foobar --zone us-central1  --format="value(endpoint)"
