# Terraform-from-scratch-on-AWS
This repo gives a clear picture of developing each aws component from scratch like ec2, vpc, subnets, Load Balancers, route53, Auto Scaling Groups and integrating each with others to finally build a  code build and code-pipeline with dynamic fashion of provisioning Dev and stage env with end to end deployments

# AWS Services Covered
AWS VPC Virtual Private Cloud

AWS VPC NAT Gateways for Outbound Communication

AWS VPC Public and Private Subnets

AWS EC2 Instances

AWS Security Groups

AWS Classic Load Balancer

AWS ALB Application Load Balancer - Basic

AWS ALB Context-Path based Routing

AWS ALB Host-Header based Routing

AWS ALB Custom-HTTP Header based Routing

AWS ALB Query String based Redirects

AWS Autoscaling with Launch Configurations

AWS Autoscaling with Launch Templates

AWS Network Load Balancer

AWS CloudWatch Alarms

AWS Certificate Manager (ACM)

AWS Route53

AWS CodeBuild

AWS CodePipeline

AWS RDS Database

AWS Elastic IP

AWS SNS

Terraform Concepts Covered
Terraform Install
Command Basics (init, validate, plan, apply)
Language Syntax (Blocks, Arguments)
Settings Block
Provider Block
Resources Block
Resource Meta-Arguments (depends_on, count, for_each)
Input Variables - Basics
Input Variables - Assign When Prompted
Input Variables - Override default with cli var
Input Variables - Assign with terraform.tfvars
Input Variables - Assign with tfvars var-file argument
Input Variables - Assign with auto tfvars
Input Variables - Lists
Input Variables - Maps
Input Variables - Sensitive Input Variables
Function: File
Output Values
Local Values
Datasources
Backends - Remote State Storage
File Provisioner
local-exec Provisioner
remote-exec Provisioner
Null Resource
Modules from Public Registry
Build Local Module
For Loop with Lists
For Loop with Maps
For Loops with Advanced Maps
Legacy Splat Operator
Latest Splat Operator
Function: toset
Function: tomap
Function: keys
Module Upgrades
Random Resource
Terraform Import
