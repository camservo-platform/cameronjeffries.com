global:
  domain: argo.fuckamazon.org

configs:
  params:
    server.insecure: true
  cm:
    # -- Create the argocd-cm configmap for [declarative setup]
    create: true

    # OIDC configuration as an alternative to dex (optional).
    oidc.config: |
      name: Keycloak
      issuer: http://keycloak.kind.cluster/auth/realms/master
      clientID: argocd
      clientSecret: {{ keycloak_secret }}
      requestedScopes: ['openid', 'profile', 'email', 'groups']

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
