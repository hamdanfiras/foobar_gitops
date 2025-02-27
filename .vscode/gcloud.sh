gcloud config set project dummy-59e81
gcloud config set compute/zone us-east1-b
gcloud container clusters create foobar --zone us-east1-b
gcloud container clusters get-credentials foobar

kubectl create namespace argocd

exit 0

# after

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d && echo

