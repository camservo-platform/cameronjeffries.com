1. helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
2. helm repo update
3. helm install ingress-nginx ingress-nginx/ingress-nginx -n nginx --create-namespace
