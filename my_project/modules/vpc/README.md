# This module creates a basic AWS VPC setup for public networking.

## What it does:
- Creates a VPC with a custom CIDR block  
- Adds two public subnets (across different AZs)  
- Adds an Internet Gateway  
- Creates a public Route Table and associates it with the subnets  

## Recommended variables to customize:

| Variable            | Description                                  |
|---------------------|----------------------------------------------|
| vpc_name            | Name for the VPC                             |
| vpc_cidr            | CIDR block for the VPC                       |
| subnet_count        | List of CIDRs for public subnets             |
| public_subnet_name  | Name tag for public subnets                  |
| igw_name            | Name tag for the Internet Gateway            |
| public_rt_name      | Name for the route table                     |
| tags                | Custom tags to apply to all resources        |

## Outputs:

| Output  | Description                   |
|---------|-------------------------------|
| vpc     | VPC ID                        |
| subnet  | List of public subnet IDs     |
| rt      | Public route table object     |
