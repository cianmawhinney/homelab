provider "flux" {
  kubernetes = {
    host                   = module.cluster.kubeconfig_data.host
    client_certificate     = module.cluster.kubeconfig_data.client_certificate
    client_key             = module.cluster.kubeconfig_data.client_key
    cluster_ca_certificate = module.cluster.kubeconfig_data.cluster_ca_certificate
  }
  git = {
    url    = "https://github.com/${var.github_org}/${var.github_repository}.git"
    branch = var.github_branch
    http = {
      username = "git" # can be any string when authenticating with a PAT
      password = var.github_token
    }
  }
}

resource "flux_bootstrap_git" "this" {
  path = "kubernetes/clusters/prod"
}
