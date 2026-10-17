---
# Created ahead of the Flux bootstrap, which adopts the namespace
apiVersion: v1
kind: Namespace
metadata:
  name: flux-system
---
# age key Flux uses to decrypt *.sops.yaml files
apiVersion: v1
kind: Secret
metadata:
  name: sops-age
  namespace: flux-system
type: Opaque
data:
  age.agekey: ${base64encode(sops_age_key)}
