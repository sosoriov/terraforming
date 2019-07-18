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

# resource "local_file" "kubeconfig" {
#   content  = yamlencode(digitalocean_kubernetes_cluster.kubernetes_id.kube_config.0.raw_config)
#   # make sure the "~/.kube" paths exists
#   filename = pathexpand("~/.kube/config")

#   depends_on = [digitalocean_kubernetes_cluster.kubernetes_id]
# }

provider "kubernetes" {
  host = digitalocean_kubernetes_cluster.kubernetes_id.endpoint

  client_certificate     = base64decode(digitalocean_kubernetes_cluster.kubernetes_id.kube_config.0.client_certificate)
  client_key             = base64decode(digitalocean_kubernetes_cluster.kubernetes_id.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(digitalocean_kubernetes_cluster.kubernetes_id.kube_config.0.cluster_ca_certificate)
}


resource "kubernetes_service_account" "tiller" {
  metadata {
    name = "tiller"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "tiller" {
  metadata {
    name = "tiller"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name = "cluster-admin"
  }

  subject {
    kind = "ServiceAccount"
    name = kubernetes_service_account.tiller.metadata[0].name
    namespace = kubernetes_service_account.tiller.metadata[0].namespace

    api_group = ""
  }

  depends_on = [
    "kubernetes_service_account.tiller"
  ]
}

provider "helm" {
  install_tiller = true
  service_account = kubernetes_service_account.tiller.metadata[0].name
}

resource "null_resource" "install_tiller" {
  provisioner "local-exec" {
    command = "${"helm init --service-account tiller"}"
    interpreter = ["PowerShell", "-Command"]
  }

  depends_on = [
    "kubernetes_cluster_role_binding.tiller",
    "kubernetes_service_account.tiller"
  ]

  provisioner "local-exec" {
    command = "sleep 20"
  }
}


