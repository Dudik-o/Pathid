resource "kind_cluster" "pathid" {
  name           = "pathid"
  wait_for_ready = true
  node_image     = "kindest/node:v1.30.0"

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"

      extra_port_mappings {
        container_port = 30080
        host_port      = 80
        listen_address = "0.0.0.0"
        protocol       = "TCP"
      }

      extra_port_mappings {
        container_port = 30443
        host_port      = 443
        listen_address = "0.0.0.0"
        protocol       = "TCP"
      }
    }

    node {
      role = "worker"
    }
  }
}

resource "local_file" "pathid_kubeconfig" {
  content  = kind_cluster.pathid.kubeconfig
  filename = pathexpand("~/.kube/kind-pathid.yaml")
}