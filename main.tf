variable "do_token" {
    description = "Digital Ocean API token"
}

provider "digitalocean" {
  token = "${var.do_token}"
}

module "kubernetes" {
  source = "./kubernetes"


  kubernetes_version = "${var.kubernetes_version}"
  name = "${var.kubernetes_cluster_name}"
  region = "${var.cluster_region}"
  tags = "${var.cluster_tags}"

  node_pool_name = "${var.node_pool_name}"
  node_pool_size = "${var.node_capacity}"
  node_pool_node_count = "${var.number_of_nodes}"
  
}


