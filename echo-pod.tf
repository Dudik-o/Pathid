module "pod_echo" {
  source = "./helm-submodule"
  providers = {
    helm = helm
  }

  name             = "pod-echo"
  chart            = "${path.module}/pod-echo/charts"
  repository       = null
  namespace        = "default"
  create_namespace = false

  sets = [
    { name = "image.repository",  value = "pod-echo" },
    { name = "image.tag",         value = "0.1" },
    { name = "replicaCount",      value = 2 },         
    { name = "ingress.enabled",   value = "true" },    
    { name = "ingress.className", value = "nginx" },
    { name = "ingress.host",      value = "localhost" },
    { name = "ingress.path",      value = "/info" },
    { name = "ingress.pathType",  value = "Prefix" },
  ]
  depends_on = [null_resource.load_image ]
}


resource "null_resource" "load_image" {
  provisioner "local-exec" {
    command = "kind load docker-image pod-echo:0.1 --name pathid"
  }
  depends_on = [ module.nginx_ingress ]
}