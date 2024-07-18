# Deployment
---
1. kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.crds.yaml
2. kubectl create namespace cert-manager
3. helm repo add cert-manager https://charts.jetstack.io
4. helm repo update
5. Install the helm chart
    ```
    helm install \
        cert-manager jetstack/cert-manager \
        --namespace cert-manager \
        --create-namespace \
        --version v1.15.1 \
        --set crds.enabled=true
    ```
6. kubectl create -f acme-issuer-prod.yaml
7. Configure letsencrypt issuers.  Currently requires an issuer per namespace:
   1. Staging: `kubectl apply -f cert-manager.staging.yaml`
   2. Production: `kubectl apply -f cert-manager.prod.yaml` 


# Testing
---
This should be fixed to allow parameterized values and handle secrets, possibly from a vault connection.
1. `helm upgrade --install cert-manager-test tests/cert-manager-test --namespace test --create-namespace`