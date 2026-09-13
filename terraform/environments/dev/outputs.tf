output "kubeconfig" {
  description = "Kubeconfig file content for this cluster"
  value       = module.cluster.kubeconfig
  sensitive   = true
}

output "kubeconfig_data" {
  description = "Structured kubeconfig data (host, client cert/key, CA) for this cluster"
  value       = module.cluster.kubeconfig_data
  sensitive   = true
}
