# Build AWS EC2 Instances, Security Groups using Terraform

## Step-01: Introduction
### Terraform Modules we will use
- [terraform-aws-modules/vpc/aws](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
- [terraform-aws-modules/security-group/aws](https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest)
- [terraform-aws-modules/ec2-instance/aws](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest)

### Terraform New Concepts we will introduce
- [aws_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)
- [null_resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)
- [file provisioner](https://www.terraform.io/docs/language/resources/provisioners/file.html)
- [remote-exec provisioner](https://www.terraform.io/docs/language/resources/provisioners/remote-exec.html)
- [local-exec provisioner](https://www.terraform.io/docs/language/resources/provisioners/local-exec.html)
- [depends_on Meta-Argument](https://www.terraform.io/docs/language/meta-arguments/depends_on.html)

### What are we going implement? 
- Create VPC with 3-Tier Architecture (Web, App and DB) - Leverage code from previous section
- Create AWS Security Group Terraform Module and define HTTP port 80, 22 inbound rule for entire internet access `0.0.0.0/0`
- Create Multiple EC2 Instances in VPC Private Subnets and install 
- Create EC2 Instance in VPC Public Subnet `Bastion Host`
- Create Elastic IP for `Bastion Host` EC2 Instance
- Create `null_resource` with following 3 Terraform Provisioners
  - File Provisioner
  - Remote-exec Provisioner
  - Local-exec Provisioner
 
## Pre-requisite
- Copy your AWS EC2 Key pair `terraform-key.pem` in `private-key` folder
- Folder name `local-exec-output-files` where `local-exec` provisioner creates a file (creation-time provisioner)

## Step-02: Copy all the VPC TF Config files from 06-02
- Copy the following TF Config files from 06-02 section which will create a 3-Tier VPC
- c1-versions.tf
- c2-generic-variables.tf
- c3-local-values.tf
- c4-01-vpc-variables.tf
- c4-02-vpc-module.tf
- c4-03-vpc-outputs.tf
- terraform.tfvars
- vpc.auto.tfvars
- private-key/terraform-key.pem

## Step-03: Add app1-install.sh
- Add `app1-install.sh` in working directory
```sh
#! /bin/bash
# Instance Identity Metadata Reference - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-identity-documents.html
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start  
sudo echo '<h1>Welcome to Vinod Terraform project from scratch on AWS- APP-1</h1>' | sudo tee /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Vinod Terraform project from scratch on AWS- APP-1</h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
#sudo curl http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app1/metadata.html
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
sudo curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app1/metadata.html
# AWS Documentation to retrieve EC2 Instance Data
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html
```

## Step-04: Create Security Groups for Bastion Host and Private Subnet Hosts
### Step-04-01: c5-01-securitygroup-variables.tf
- Place holder file for defining any Input Variables for EC2 Security Groups

### Step-04-02: c5-03-securitygroup-bastionsg.tf
- [SG Module Examples for Reference](https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest/examples/complete)
```t
# AWS EC2 Security Group Terraform Module
# Security Group for Public Bastion Host
# AWS EC2 Security Group Terraform Module
# Security Group for Public Bastion Host

```
### Step-04-03: c5-04-securitygroup-privatesg.tf
```t
# AWS EC2 Security Group Terraform Module
# Security Group for Private EC2 Instances
# AWS EC2 Security Group Terraform Module
# Security Group for Public Bastion Host

```

### Step-04-04: c5-02-securitygroup-outputs.tf
- [SG Module Examples for Reference](https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest/examples/complete)
```t

# Public Bastion Host Security Group Outputs


# Private EC2 Instances Security Group Outputs

```

## Step-05: c6-01-datasource-ami.tf
```t
# Get latest AMI ID for Amazon Linux2 OS
# Get latest AMI ID for Amazon Linux OS

```

## Step-06: EC2 Instances
### Step-06-01: c7-01-ec2instance-variables.tf
```t
# AWS EC2 Instance Type

# AWS EC2 Instance Key Pair

```
### Step-06-02: c7-03-ec2instance-bastion.tf
- [Example EC2 Instance Module for Reference](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest/examples/basic)
```t
# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet

```
### Step-06-03: c7-04-ec2instance-private.tf
- [Example EC2 Instance Module for Reference](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest/examples/basic)
```t

# EC2 Instances that will be created in VPC Private Subnets

```
### Step-06-04: c7-02-ec2instance-outputs.tf
```t
# AWS EC2 Instance Terraform Outputs
# Public EC2 Instances - Bastion Host
# Private EC2 Instances outputs

```

## Step-07: EC2 Elastic IP for Bastion Host - c8-elasticip.tf
- learn about [Terraform Resource Meta-Argument `depends_on`](https://www.terraform.io/docs/language/meta-arguments/depends_on.html)
```t
# Create Elastic IP for Bastion Host
# Resource - depends_on Meta-Argument
```

## Step-08: c9-nullresource-provisioners.tf
### Step-08-01: Define null resource in c1-versions.tf
- Learn about [Terraform Null Resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)
- Define null resource in c1-versions.tf in `terraform block`
```t
    null = {
      source = "hashicorp/null"
      version = "~> 3.0.0"
    }    
```

### Step-08-02: Understand about Null Resource and Provisioners
- Learn about Terraform Null Resource
- Learn about [Terraform File Provisioner](https://www.terraform.io/docs/language/resources/provisioners/file.html)
- Learn about [Terraform Remote-Exec Provisioner](https://www.terraform.io/docs/language/resources/provisioners/remote-exec.html)
- Learn about [Terraform Local-Exec Provisioner](https://www.terraform.io/docs/language/resources/provisioners/local-exec.html)
```t
# Create a Null Resource and Provisioners

  # Connection Block for Provisioners to connect to EC2 Instance
 # Copies the terraform-key.pem file to /tmp/terraform-key.pem

# Using remote-exec provisioner fix the private key permissions on Bastion Host
  # local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
## Local Exec Provisioner:  local-exec provisioner (Destroy-Time Provisioner - Triggered during deletion of Resource)

```

## Step-09: ec2instance.auto.tfvars
```t
# EC2 Instance Variables

```
## Step-10: Usage of depends_on Meta-Argument
### Step-10-01: c7-04-ec2instance-private.tf
- We have put `depends_on` so that EC2 Private Instances will not get created until all the resources of VPC module are created
- **why?**
- VPC NAT Gateway should be created before EC2 Instances in private subnets because these private instances has a `userdata` which will try to go outbound to download the `HTTPD` package using YUM to install the webserver
- If Private EC2 Instances gets created first before VPC NAT Gateway provisioning of webserver in these EC2 Instances will fail.
```t
depends_on = [module.vpc]
```

### Step-10-02: c8-elasticip.tf
- We have put `depends_on` in Elastic IP resource. 
- This elastic ip resource will explicitly wait for till the bastion EC2 instance `module.ec2_public` is created. 
- This elastic ip resource will wait till all the VPC resources are created primarily the Internet Gateway IGW.
```t
depends_on = [module.ec2_public, module.vpc]
```

### Step-10-03: c9-nullresource-provisioners.tf
- We have put `depends_on` in Null Resource
- This Null resource contains a file provisioner which will copy the `private-key/terraform-key.pem` to Bastion Host `ec2_public module created ec2 instance`. 
- So we added explicit dependency in terraform to have this `null_resource` wait till respective EC2 instance is ready so file provisioner can copy the `private-key/terraform-key.pem` file
```t
 depends_on = [module.ec2_public ]
```

## Step-11: Execute Terraform Commands
```t
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan
Observation: 
1) Review Security Group resources 
2) Review EC2 Instance resources
3) Review all other resources (vpc, elasticip) 

# Terraform Apply
terraform apply -auto-approve
Observation:
1) VERY IMPORTANT: Primarily observe that first VPC NAT Gateway will be created and after that only module.ec2_private related EC2 Instance will be created
```


## Step-12: Connect to Bastion EC2 Instance and Test
```t
# Connect to Bastion EC2 Instance from local desktop
ssh -i private-key/terraform-key.pem ec2-user@<PUBLIC_IP_FOR_BASTION_HOST>

# Curl Test for Bastion EC2 Instance to Private EC2 Instances
curl  http://<Private-Instance-1-Private-IP>
curl  http://<Private-Instance-2-Private-IP>

# Connect to Private EC2 Instances from Bastion EC2 Instance
ssh -i /tmp/terraform-key.pem ec2-user@<Private-Instance-1-Private-IP>
cd /var/www/html
ls -lrta
Observation: 
1) Should find index.html
2) Should find app1 folder
3) Should find app1/index.html file
4) Should find app1/metadata.html file
5) If required verify same for second instance too.
6) # Additionalyy To verify userdata passed to Instance
curl http://169.254.169.254/latest/user-data 

# Additional Troubleshooting if any issues
# Connect to Private EC2 Instances from Bastion EC2 Instance
ssh -i /tmp/terraform-key.pem ec2-user@<Private-Instance-1-Private-IP>
cd /var/log
more cloud-init-output.log
Observation:
1) Verify the file cloud-init-output.log to see if any issues
2) This file (cloud-init-output.log) will show you if your httpd package got installed and all your userdata commands executed successfully or not
```

## Step-13: Clean-Up
```t
# Terraform Destroy
terraform destroy -auto-approve

# Clean-Up
rm -rf .terraform*
rm -rf terraform.tfstate*
```
