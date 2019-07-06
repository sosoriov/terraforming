resource "digitalocean_kubernetes_cluster" "kubernetes_id" {
  name    = var.name
  region  = var.region
  version = var.kubernetes_version
  tags    = var.tags

  node_pool {
    name       = var.node_pool_name
    size       = var.node_pool_size
    node_count = var.node_pool_node_count
  }
}

resource "local_file" "kubeconfig" {
  content  = yamlencode(digitalocean_kubernetes_cluster.kubernetes_id.kube_config.0.raw_config)
  # make sure the "~/.kube" paths exists
  filename = pathexpand("~/.kube/config")

  depends_on = [digitalocean_kubernetes_cluster.kubernetes_id]
}