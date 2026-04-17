# Work 8: Jenkins

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




























