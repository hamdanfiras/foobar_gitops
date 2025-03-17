minikube start

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl create -f https://download.elastic.co/downloads/eck/2.16.1/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/2.16.1/operator.yaml

