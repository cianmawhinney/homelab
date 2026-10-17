#!/usr/bin/env bash
set -o errexit

cluster_path='kubernetes/clusters/local/flux-system'
flux_ks='flux-system'
age_key="${SOPS_AGE_KEY_FILE:-$HOME/.config/sops/age/keys.txt}"

if [ ! -f "${age_key}" ]; then
  echo "age key not found at ${age_key}, retrieve this from your password manager!" >&2
  exit 1
fi

ec=0
flux get ks ${flux_ks} 2>/dev/null || ec=1

if [ "${ec}" -eq 1 ]; then
  echo "starting bootstrap"
  flux install --components=source-controller,kustomize-controller \
    --registry=docker.io/fluxcd
fi

# Load the sops key into the cluster to decrypt the secrets this cluster has access to
kubectl -n flux-system create secret generic sops-age \
  --from-file=age.agekey="${age_key}" \
  --dry-run=client -o yaml | kubectl apply -f -

if [ "${ec}" -eq 1 ]; then
  kubectl apply -k "${cluster_path}"

  kubectl -n flux-system wait kustomization/${flux_ks} --for=condition=ready --timeout=5m
fi
