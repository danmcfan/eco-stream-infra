terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "2.7.1"
    }
  }
}

provider "linode" {
  token = var.token
}


resource "linode_lke_cluster" "this" {
  k8s_version = var.k8s_version
  label       = var.label
  region      = var.region
  tags        = var.tags

  dynamic "pool" {
    for_each = var.pools
    content {
      type  = pool.value["type"]
      count = pool.value["count"]
    }
  }
}

output "kubeconfig" {
  value     = linode_lke_cluster.this.kubeconfig
  sensitive = true
}

output "api_endpoints" {
  value = linode_lke_cluster.this.api_endpoints
}

output "status" {
  value = linode_lke_cluster.this.status
}

output "id" {
  value = linode_lke_cluster.this.id
}

output "pool" {
  value = linode_lke_cluster.this.pool
}
