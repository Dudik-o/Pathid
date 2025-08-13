terraform {
  required_version = "1.5.7"
  required_providers {
    kind  = { source = "tehcyx/kind",  version = "~> 0.5" }
    local = { source = "hashicorp/local", version = "~> 2.5" }
    helm = { source  = "hashicorp/helm", version = "~> 2.13",} 
    kubernetes = {source  = "hashicorp/kubernetes", version = "~> 2.25"}
  }
}


provider "kubernetes" {
  config_path = "~/.kube/kind-pathid.yaml"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/kind-pathid.yaml"
  }
}