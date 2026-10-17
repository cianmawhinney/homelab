---
# Rendered and applied by kube-hetzner on the first control plane node
# (see extra_kustomize_* in ../main.tf)
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - sops-age.yaml
