# # final/modules/argo_cd/helm_release_django.tf

# resource "helm_release" "django" {
#   name       = "django-app"
#   chart      = "${path.module}/../charts/django-app"
#   namespace  = "default"

#   set = [
#     {
#       name  = "config.POSTGRES_HOST"
#       value = module.rds.aurora_endpoint
#     },
#     {
#       name  = "config.POSTGRES_DB"
#       value = module.rds.db_name
#     },
#     {
#       name  = "config.POSTGRES_USER"
#       value = module.rds.db_user
#     }
#   ]

#    set_sensitive = [
#     {
#        name  = "config.POSTGRES_PASSWORD"
#        value = module.rds.db_password
#      }
#    ]
# }
