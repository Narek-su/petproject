# This module creates:

- An Application Load Balancer (ALB)  
- A Target Group (HTTP, port 80)  
- A Listener to forward traffic from the ALB to the target group  

---

## What it does

- Creates a public or internal ALB based on configuration  
- Registers a Target Group for forwarding HTTP traffic (port 80)  
- Adds a Listener on port 80 to forward traffic to the target group  
- Supports tagging and security group association  

---

## Recommended variables to customize

| Variable                | Description                                                      |
|-------------------------|------------------------------------------------------------------|
| `lb_name`               | Name of the Load Balancer                                        |
| `lb_type`               | Type of Load Balancer                                            |
| `internal`              | `true` for internal ALB, `false` for internet-facing             |
| `security_group_id`     | Security Group ID to associate with the ALB                      |
| `subnet`                | List of Subnet IDs where the ALB will be deployed                |
| `vpc_id`                | VPC ID for the Target Group                                      |
| `vpc_cidr` *(optional)* | CIDR block for reference (not used in any resources)             |
| `tg_name`               | Name of the Target Group                                         |
| `tags`                  | Map of tags to apply to all created resources                    |

---

## Outputs

| Output            | Description                      |
|-------------------|----------------------------------|
| `alb_dns_name`    | DNS name of the created ALB      |
| `target_group_arn`| ARN of the created Target Group  |
