variable "cluster_name" {
  description = "Name of the cluster to bootstrap. Will be added as a subpath to the Git repository"
}

variable "github_repository" {
  description = "The name of the repository to hold the Flux K8s configs"
}
