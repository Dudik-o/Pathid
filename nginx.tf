module "nginx_ingress" {
  source = "./helm-submodule"
  providers = {
    helm = helm
  }
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true

  sets = [
    { name = "controller.kind",                    value = "Deployment" },
    { name = "controller.service.type",            value = "NodePort" },
    { name = "controller.service.nodePorts.http",  value = "30080" },
    { name = "controller.service.nodePorts.https", value = "30443" },
    { name = "controller.replicaCount",            value = 1 },
    { name = "ingress.className",                  value = "nginx" }
  ]
  depends_on = [ kind_cluster.pathid ]
}