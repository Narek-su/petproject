# This module creates:
- A Launch Template with a user-data script to install NGINX  
- An Auto Scaling Group (ASG) attached to a Target Group  

## What it does:
- Uses the latest Ubuntu 22.04 AMI (via a data source)  
- Installs NGINX on launch  
- Automatically scales EC2 instances based on configuration  
- Associates EC2 instances with provided subnets and a target group  

## Recommended variables to customize:
| Variable                             | Description                                                        |
|--------------------------------------|--------------------------------------------------------------------|
| launch_template_name                 | Name of the EC2 launch template                                    |
| instance_name                        | Name tag for EC2 instances                                         |
| instance_type                        | EC2 instance type (e.g., t3.micro)                                 |
| key_name                             | EC2 key for SSH access. Must exist in AWS or be created manually   |
| security_group_id                    | Security Group ID to associate with EC2                            |
| subnet                               | List of subnet IDs for ASG                                         |
| asg_name                             | Name of the Auto Scaling Group                                     |
| scaling_size                         | Object with min, max, and desired instance counts                  |
| target_group_arn                     | List of ALB Target Group ARNs                                      |
| ami_id (Optional)                    | Custom AMI ID. Defaults to latest Ubuntu 22.04 if empty            |
| cpu_credits                          | CPU credit type for T3/T4 instances                                |
| ebs                                  | EBS config: volume size, type, delete on termination               |
| metadata_options                     | EC2 instance metadata settings                                     |
| instance_initiated_shutdown_behavior | Action on shutdown (e.g., terminate)                               |
| user_data_file                       | Path to shell script to be used as user data                       |
| tags                                 | Map of tags to apply                                               |

## Output:
| Output     | Description                               |
|------------|-------------------------------------------|
| asg_name   | Name of the created Auto Scaling Group    |

## Note about AMI:
The AMI is selected dynamically via a data "aws_ami" resource filtering for the latest Ubuntu 22.04 image. You can replace this AMI by changing the filters or specifying your own AMI ID directly in the launch template if needed.
