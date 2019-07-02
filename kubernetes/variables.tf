variable name {}
variable region {}
variable kubernetes_version  {}
variable tags {
    type = "list"
}

// node pool variables
variable node_pool_name {}

variable "node_pool_size" {
  default = "s-2vcpu-2gb"
}

variable "node_pool_node_count" {
  default = 1
}