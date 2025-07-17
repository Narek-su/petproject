# Scalable Web App on AWS (Terraform)

This Terraform root module deploys a highly available, auto-scaled web application on AWS.  
It uses EC2 instances behind an Application Load Balancer (ALB), running on Ubuntu with NGINX installed.

---

## What it creates

- VPC with Internet Gateway, public subnets, and route tables
- Security Groups for ALB and EC2 with flexible rule configuration
- Application Load Balancer (ALB) with HTTP listener and target group
- Launch Template with NGINX installation script via user data
- Auto Scaling Group (ASG) using the Launch Template

---

## Recommended variables to customize

| Variable              | Description                                                               |
|-----------------------|---------------------------------------------------------------------------|
| `vpc_cidr`            | CIDR block for the VPC                                                    |
| `subnet_count`        | List of subnet CIDRs                                                      |
| `sg_name.lb`          | Name for the ALB security group                                           |
| `sg_name.ec2`         | Name for the EC2 security group                                           |
| `lb_name`             | Name of the ALB                                                           |
| `internal`            | Whether ALB is internal (`true`) or internet-facing (`false`)             |
| `launch_template_name`| Name of the EC2 Launch Template                                           |
| `instance_name`       | Name tag for the EC2 instances                                            |
| `asg_name`            | Auto Scaling Group name                                                   |
| `scaling_size`        | ASG scaling settings (`min`, `max`, `desired`)                            |
| `ami_id` *(optional)* | AMI ID to use (leave empty for default Ubuntu 22.04)                      |
| `user_data_file`      | Path to a shell script (e.g., `install_nginx.sh`) for EC2 user data setup |

---

## Outputs

| Output              | Description                      |
|---------------------|----------------------------------|
| `alb_dns`           | DNS name of the ALB (access URL) |
| `public_subnet_ids` | Subnet IDs created               |
| `asg_name`          | Name of the Auto Scaling Group   |

---

## Requirements

- Terraform v1.12.2  
- AWS CLI installed and configured (`aws configure`)  
- S3 bucket for storing remote state (see `terraform.backend` section in `main.tf`)  

---

## How to use

```bash
git clone https://github.com/Narek-su/petproject.git

cd my_project/envs/dev

# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Apply the configuration
terraform apply
