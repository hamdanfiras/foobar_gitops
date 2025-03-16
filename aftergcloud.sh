password=$(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d) && echo "ArgoCD initial admin password: $password"
sleep 1
kubectl port-forward svc/argocd-server -n argocd 8086:443 &> /dev/null &


sleep 2

argocd login "localhost:8086" --username admin --password $password --insecure 

argocd repo add https://github.com/hamdanfiras/foobar_gitops --username hamdanfiras --password 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

kubectl apply -f ./apps/root-dev.yml  