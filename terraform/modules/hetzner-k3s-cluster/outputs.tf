output "kubernetes_cluster_secret" {
  description = "Secret token used to join nodes to the cluster"
  value       = random_password.k3s_token.result
  sensitive   = true
}

output "cluster_ca_certificate" {
  value = local.cluster_ca_certificate
  sensitive = true
}

output "client_certificate" {
  value = local.client_certificate
  sensitive = true
}

output "client_key" {
  value = local.client_key
  sensitive = true
}

output "api_endpoint" {
  value = "https://${hcloud_server.master_node.ipv4_address}:6443"
}
