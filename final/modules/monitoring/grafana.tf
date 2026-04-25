# final/modules/monitoring/grafana.tf

resource "helm_release" "grafana" {
  name             = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  namespace        = "monitoring"
  create_namespace = true
  version          = "8.0.0"

  set = [  
  {
    name  = "service.type"
    value = "LoadBalancer"
  },
  {
    name  = "service.port"
    value = "3000"
  }
  ]

  set_sensitive = [
    {
      name  = "adminPassword"
      value = var.grafana_admin_password
    }
  ]
}
