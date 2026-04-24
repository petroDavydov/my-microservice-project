<!-- final/README_final.md -->
# FINAL HomeWork: Jenkins && Argo CD && Aurora/RDS && Django && MONITORING (PROMETHEUS + GRAFANA)

### СТРУКТУРА ПРОЕКТУ ТА КОМАНДИ ЯКІ БУЛИ ВИКОРИСТАНІ В ДАНІЙ РОБОТІ
##### *декотрі файли з'являються після розгортання terraform та виконання певних команд*


```python
/my-microservice-project/final$ tree
.
├── Django
│   ├── django
│   │   ├── Dockerfile
│   │   ├── goit
│   │   │   ├── __init__.py
│   │   │   ├── asgi.py
│   │   │   ├── settings.py
│   │   │   ├── urls.py
│   │   │   └── wsgi.py
│   │   ├── manage.py
│   │   └── requirements.txt
│   ├── docker-compose.yaml
│   └── nginx
│       └── default.conf
├── Jenkinsfile
├── README_final.md
├── backend.tf
├── charts
│   └── django-app
│       ├── Chart.yaml
│       ├── templates
│       │   ├── configmap.yaml
│       │   ├── deployment.yaml
│       │   ├── hpa.yaml
│       │   └── service.yaml
│       └── values.yaml
├── main.tf
├── modules
│   ├── argo_cd
│   │   ├── argo_cd.tf
│   │   ├── charts
│   │   │   ├── Chart.yaml
│   │   │   ├── templates
│   │   │   │   ├── application.yaml
│   │   │   │   └── repository.yaml
│   │   │   └── values.yaml
│   │   ├── helm_release_django.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   ├── values.yaml
│   │   └── variables.tf
│   ├── ecr
│   │   ├── ecr.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── eks
│   │   ├── aws_ebs_csi_driver.tf
│   │   ├── eks.tf
│   │   ├── node.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── jenkins
│   │   ├── jenkins.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   ├── values.yaml
│   │   └── variables.tf
│   ├── monitoring
│   │   ├── grafana.tf
│   │   ├── outputs.tf
│   │   └── prometheus.tf
│   ├── rds
│   │   ├── aurora.tf
│   │   ├── outputs.tf
│   │   ├── rds.tf
│   │   ├── shared.tf
│   │   └── variables.tf
│   ├── s3-backend
│   │   ├── dynamodb.tf
│   │   ├── outputs.tf
│   │   ├── s3.tf
│   │   └── variables.tf
│   └── vpc
│       ├── outputs.tf
│       ├── routes.tf
│       ├── variables.tf
│       └── vpc.tf
└── outputs.tf

19 directories, 60 files
```








































1. Ініціалізація Terraform та створення ресурсів

```bash
cd lesson-db-module

terraform init
terraform validate
terraform plan -out=tfplan
terraform apply tfplan

```

Remote Backend

```bash
# Розкоментувати backend.tf
terraform init -migrate-state

```


2. Підключення до EKS

```bash
aws eks update-kubeconfig --region <region> --name <claster_name>
kubectl config current-context
kubectl get nodes -o wide
```


3. Jenkins

```bash
terraform apply -target=module.jenkins
kubectl get pods -n jenkins
```

4. Argo CD

```bash
terraform apply -target=module.argo_cd

kubectl get pods -n argocd
kubectl get svc -n argocd

# LoadBalancer URL Argo CD
kubectl get svc -n argocd argo-cd-argocd-server -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'

kubectl get applications -n argocd

```


5. Django

```bash
helm upgrade --install django-app ./charts/django-app -n default
kubectl get pods -n default
kubectl logs -n default -l app=django-app-django

kubectl get svc -n default

# LoadBalancer URL Django
kubectl get svc -n default django-app-django -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'

```

6. Підключення та міграції бази

```bash
# створюється global-bundle.pem
curl -o global-bundle.pem https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem

export RDSHOST="myapp-db-cluster.cluster-cpoe6ggcw873.eu-west-1.rds.amazonaws.com" 
psql "host=$RDSHOST port=5432 dbname=myapp user=postgres sslmode=verify-full sslrootcert=./global-bundle.pem"

# міграція у кластері
kubectl exec -it <django-pod> -n default -- python manage.py migrate
```


7. Створення суперкористувача

```bash
kubectl exec -it <django-pod> -n default -- python manage.py createsuperuser
```

8. Перевірка доступності

```bash
kubectl get svc django-app-django -n default
curl -I http://<ELB_DNS>/admin/
```

9. Перевірка кластера та ресурсів

```bash
kubectl config get-contexts
kubectl config current-context
kubectl get nodes

kubectl get pods -n default
kubectl describe pod <pod_name> -n default
kubectl logs <pod_name> -n default

kubectl get deployments -n default
kubectl describe deployment django-app-django -n default
kubectl get rs -n default

kubectl get svc -n default
kubectl describe svc django-app-django -n default

kubectl get ingress -n default
kubectl describe ingress -n default
```

10. Моніторинг та стан - при наявності встановлення

```bash
kubectl top pods -n default
kubectl top nodes

kubectl get events -n default --sort-by=.metadata.creationTimestamp

kubectl get configmap -n default
kubectl describe configmap <configmap_name> -n default

kubectl get secrets -n default
kubectl describe secret <secret_name> -n default
```

11. Візуалізація графа залежностей (у роботі збережено файл graph.png)

```bash
terraform graph | dot -Tpng > graph.png
```


12. Cleanup

```bash
helm uninstall jenkins -n jenkins --ignore-not-found
helm uninstall argo-cd -n argocd --ignore-not-found



*закоментуваити helm_release_django.tf 
terraform destroy -lock=false

aws ecr delete-repository \
  --repository-name lesson-db-module \
  --region eu-west-1 --force
```


### Скріншоти



![argocd](/lesson-db-module/screenshot/argocd.png)


![jnkins](/lesson-db-module/screenshot/jenkins.png)


![django](/lesson-db-module/screenshot/django.png)


![db_1](/lesson-db-module/screenshot/db_1.png)


![db_2](/lesson-db-module/screenshot/db_2.png)














































































































































