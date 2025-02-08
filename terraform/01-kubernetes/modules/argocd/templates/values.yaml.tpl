global:
  domain: argo.fuckamazon.org

configs:
  params:
    server.insecure: true

server:
  ingress:
    enabled: true
    ingressClassName: nginx
    annotations:
      nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
      nginx.ingress.kubernetes.io/backend-protocol: "HTTP"
    extraTls:
      - hosts:
        - argo.fuckamazon.org
        # Based on the ingress controller used secret might be optional
        secretName: argo-fuckamazon-org-tls
  rbac:
    policy.default: role:readonly
    policy.csv: |
      g, argocd-admin, role:admin
    oidc.config: |
      name: Keycloak
      issuer: http://keycloak.kind.cluster/auth/realms/master
      clientID: argocd
      clientSecret: $CLIENT_SECRET
      requestedScopes: ['openid', 'profile', 'email', 'groups']