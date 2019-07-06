output "cluster_id" {
  value = digitalocean_kubernetes_cluster.kubernetes_id.id
}

output "cluster_name" {
  value = digitalocean_kubernetes_cluster.kubernetes_id.name
}

output "cluster_endpoint" {
  value = digitalocean_kubernetes_cluster.kubernetes_id.endpoint
}

output "kube_config" {
  value = digitalocean_kubernetes_cluster.kubernetes_id.kube_config.0
}
