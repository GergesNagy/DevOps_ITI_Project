# DevOps_ITI_Project

## Final Project

### Brief
Deploy backend application on kubernetes cluster using CI/CD jenkins
pipeline using the following steps and high-level diagram :
1. Implement secure kubernetes cluster
2. Deploy and configure jenkins on kubernetes using Ansinle
3. Deploy backend application on kuberetes using jenkins piepline

```bash
## We choosed AWS Cloud Plateform 
```
### First
Using Terraform {IAC} tool to build a pravite network with EC2 to Connect to the AWS in the private subnet with Nat Gateway
to aplly :> use these commands:
```bash
 terraform init
 terraform fmt
 terraform apply
```
We limit the Connection to AWS Using Master Authorized Network to Allow the Ec2 to connect to the eks cluster

### Second
Using ansible to  Automate the deployments ( jenkins master and agent ) and services ( loadbalancers and namespaces ) on AWS with roles and tasks

```bash
 ansible-playbook main.yaml 
```

### Third 
Create Dockerfile to be our deployed container 


### Forth 
Using Jenkins Pipeline to connect btw Our Repo to deployment in AWS



### Contributors:
|![Gerges Nagy](https://github.com/GergesNagy/DevOps_ITI_Project/blob/main/images/WhatsApp%20Image%202021-12-03%20at%2012.58.30%20PM.jpeg)|![Mosaab Ragab](https://github.com/GergesNagy/DevOps_ITI_Project/blob/main/images/WhatsApp%20Image%202022-02-20%20at%2010.34.07%20PM.jpeg)|![Tark Omar](https://github.com/GergesNagy/DevOps_ITI_Project/blob/main/images/WhatsApp%20Image%202022-02-20%20at%2011.01.48%20PM.jpeg)|
|:-----------------:|:-----------------:|:-----------------:|
|[Gerges Nagy](https://github.com/GergesNagy/DevOps_ITI_Project)|[Mossab Ragab]()|[Tarek Omar](https://github.com/Mosaabmr)|
