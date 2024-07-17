1. Create a values file containing an env var containing your PAT for Gandi.  More info here: https://artifacthub.io/packages/helm/external-dns/external-dns (Uses name/value parameters in list.)
2. Run `helm upgrade --install external-dns external-dns/external-dns --namespace external-dns --create-namespace -f values.yaml`

You can test using the test.yaml file in the tests folder.