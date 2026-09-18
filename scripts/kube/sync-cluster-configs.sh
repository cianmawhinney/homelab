#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob
umask 077

# Rebuilds every k3s-* context in a kubeconfig from the Terraform environments'
# outputs. Contexts with that prefix are owned by this script; kube-hetzner
# names the cluster, user and context identically.

target="${1:-/usr/local/share/kube-localhost/config}"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
workdir="$(mktemp -d)"
trap 'rm -rf "${workdir}"' EXIT

# Fetch everything before touching the target, so any failure leaves it as it was.
for env_dir in "${repo_root}"/terraform/environments/*/; do
  env_name="$(basename "${env_dir}")"
  # Uninitialised directories report no outputs, which would read as a destroyed cluster.
  if [ ! -d "${env_dir}.terraform" ]; then
    echo "${env_name}: not initialised, run terraform init" >&2
    exit 1
  fi
  kubeconfig="$(terraform -chdir="${env_dir}" output -json | jq -r '.kubeconfig.value // empty')"
  if [ -n "${kubeconfig}" ]; then
    echo "${env_name}: found kubeconfig"
    printf '%s\n' "${kubeconfig}" >"${workdir}/env-${env_name}.yaml"
  else
    echo "${env_name}: no kubeconfig output, treating the cluster as absent"
  fi
done

cp "${target}" "${workdir}/existing"
for name in $(kubectl --kubeconfig="${workdir}/existing" config get-contexts -o name | grep '^k3s-' || true); do
  kubectl --kubeconfig="${workdir}/existing" config delete-context "${name}" >/dev/null 2>&1
  kubectl --kubeconfig="${workdir}/existing" config delete-cluster "${name}" >/dev/null
  kubectl --kubeconfig="${workdir}/existing" config delete-user "${name}" >/dev/null
done

# Existing config first, so its current-context wins the merge.
KUBECONFIG="${workdir}/existing:$(printf '%s:' "${workdir}"/env-*.yaml)" \
  kubectl config view --flatten >"${workdir}/merged"

cp "${target}" "${target}.bak"
# Written in place: replacing the file on the 9p mount would discard its host ACLs.
cat "${workdir}/merged" >"${target}"
