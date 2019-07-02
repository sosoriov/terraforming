variable "kubernetes_version" {
  description = "Kubernetes Version for DO pool"
  default = "1.14.1-do.4"
}

variable "kubernetes_cluster_name" {
  description = "Kubernetes cluster name"
}

variable "cluster_region" {
  description = "Cluster Region: ams3 for Amsterdam"
}

variable "cluster_tags" {
  description = "List with tags for the cluster"
  type = "list"
  default = []
}

variable "node_pool_name" {
  description = "Node pool name"
}
variable "node_capacity" {
  description = "Node resources cpu and memory"
  default = "s-1vcpu-2gb"
}
variable "number_of_nodes" {
  description = "Number of worker nodes"
  default = "2"
}




