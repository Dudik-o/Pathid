resource "helm_release" "this" {
  name             = var.name
  repository       = var.repository
  chart            = var.chart
  version          = var.chart_version
  namespace        = var.namespace
  create_namespace = var.create_namespace

  dynamic "set" {
    for_each = { for s in var.sets : s.name => s.value }
    content {
      name  = set.key
      value = set.value
    }
  }
}