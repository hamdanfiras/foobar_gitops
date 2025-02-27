gcloud config set project dummy-59e81
gcloud config set compute/zone us-east1-b
gcloud container clusters create foobar --zone us-east1-b
gcloud container clusters get-credentials foobar

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

exit 0

# after

kubectl port-forward svc/argocd-server -n argocd 8086:443
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d && echo

gcloud container clusters describe foobar --zone us-east1-b --format="value(endpoint)"
