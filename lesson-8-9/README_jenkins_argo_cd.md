<!-- lesson-8-9/README_jenkins_argo_cd.md -->
# Work 8-9: Jenkins and Argo CD

### СТРУКТУРА ПРОЕКТУ
##### *декотрі файли з'являються після розгортання terraform та виконання певних команд*


```python
~/my-microservice-project/lesson-8-9$ tree
.
├── README_jenkins_argo_cd.md
├── backend.tf
├── charts
│   ├── django-chart
│   │   ├── Chart.yaml
│   │   ├── Jenkinsfile
│   │   ├── templates
│   │   │   ├── configmap.yaml
│   │   │   ├── deployment.yaml
│   │   │   ├── hpa.yaml
│   │   │   └── service.yaml
│   │   └── values.yaml
│   └── info.txt
├── main.tf
├── modules
│   ├── argo_cd
│   │   ├── charts
│   │   │   ├── Chart.yaml
│   │   │   ├── templates
│   │   │   │   ├── application.yaml
│   │   │   │   └── repository.yaml
│   │   │   └── values.yaml
│   │   ├── jenkins.tf
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

13 directories, 42 files

```

##### Це друга частина дз 8-9, в якій додано Argo_CD. 
##### для того щоб зрозуміти що виправлено або додано читайте коментарі у коді.

------

1. Ініціалізація Terraform


cd lesson-8-9

terraform init
terraform validate
terraform plan -out=tfplan
terraform apply tfplan


2. Перехід на Remote Backend

# Розкоментувати backend.tf
terraform init -migrate-state


3. Створення базових ресурсів

terraform apply -target=module.s3_backend
terraform apply -target=module.vpc -target=module.ecr -target=module.eks


4. Підключення до EKS

aws eks update-kubeconfig --region eu-west-1 --name lesson-8-9-jenkins-argo-cd
kubectl get nodes
kubectl get pods -A


5. Деплой Jenkins

terraform apply -target=module.jenkins

# Отримати LoadBalancer URL Jenkins
kubectl get svc -n jenkins jenkins -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'



6. Деплой Argo CD

terraform apply -target=module.argo_cd

# Отримати LoadBalancer URL Argo CD
kubectl get svc -n argocd argo-cd-argo-cd-server -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'

# Перевірити Applications
kubectl get applications -n argocd


7. Перевірка Django

kubectl get pods -n default

# Отримати LoadBalancer URL Django
kubectl get svc -n default django-app -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'


8. Перевірка AWS ресурсів

aws eks list-clusters --region eu-west-1
aws ec2 describe-vpcs --region eu-west-1
aws ec2 describe-subnets --region eu-west-1
aws ec2 describe-internet-gateways --region eu-west-1
aws ec2 describe-nat-gateways --region eu-west-1
aws ecr describe-repositories --region eu-west-1
aws s3 ls


9. Візуалізація графа залежностей

terraform graph | dot -Tpng > graph.png



10. Cleanup

helm uninstall jenkins -n jenkins --ignore-not-found
helm uninstall argo-cd -n argocd --ignore-not-found

terraform destroy -lock=false


# Видалити S3 бакет
python3 -c "
import boto3
s3 = boto3.resource('s3')
bucket = s3.Bucket('lesson-8-9-jenkins-argo-cd-state-bucket-001001')
bucket.object_versions.delete()
bucket.delete()
print('S3 видалено!')
"

# Видалити ECR
aws ecr delete-repository \
  --repository-name lesson-8-9-ecr-jenkins-argo-cd \
  --region eu-west-1 --force


aws eks list-clusters --region eu-west-1












