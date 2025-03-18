
project="macro-shadow-452810-p9"
cluster="foobar"
region="us-central1"
zone="us-central1-a"

gcloud config set project $project
gcloud config set compute/zone $region

gcloud container clusters get-credentials $cluster --zone $zone 
sleep 2


password=$(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d) && echo "ArgoCD initial admin password: $password"
sleep 2
kubectl port-forward svc/argocd-server -n argocd 8086:443 &> /dev/null &


sleep 3

argocd login "localhost:8086" --username admin --password $password --insecure 