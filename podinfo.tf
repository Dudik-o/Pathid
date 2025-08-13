module "podinfo" {
  source = "./helm-submodule"
  providers = {
    helm = helm
  }

  name             = "podinfo-app1"
  repository       = "https://stefanprodan.github.io/podinfo"
  chart            = "podinfo"
  namespace        = "default"
  create_namespace = false

sets = [
  { name = "service.type",   value = "ClusterIP" },
  { name = "replicaCount",   value = 2 },
  { name = "ingress.enabled",   value = "true" },
  { name = "ingress.className", value = "nginx" },
  { name = "ingress.hosts[0].host",              value = "localhost" },
  { name = "ingress.hosts[0].paths[0].path",     value = "/podinfo" },
  { name = "ingress.hosts[0].paths[0].pathType", value = "Prefix" },
  { name = "ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/rewrite-target", value = "/" },
]
depends_on = [ module.nginx_ingress ]

}
