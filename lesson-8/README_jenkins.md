# Work 8: Jenkins

### СТРУКТУРА ПРОЕКТУ
##### *декотрі файли з'являються після розгортання terraform та виконання певних команд*


```python
~/my-microservice-project$ tree
.
├── README.md
├── commands.txt
├── info.txt
└── lesson-8
    ├── README_jenkins.md
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

11 directories, 36 files

```

##### Це перша частина дз 8-9, в якій виправлені помилки чи недопрацювання. 
##### для того щоб зрозуміти що виправлено або додано читайте коментарі у коді.




























