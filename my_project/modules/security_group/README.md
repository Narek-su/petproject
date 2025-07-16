This module creates a Security Group with flexible inbound and outbound rules.

What it does:
Creates a security group in the specified VPC
Adds dynamic inbound and outbound rules based on pre-defined rule keys
Allows overriding CIDR blocks and source security groups

Recommended variables to customize:
sg_name                 | Name for the security group                                             
vpc_id                  | VPC ID where the SG should be created                                   
inbound_rule_keys       | List of rule keys to enable for inbound traffic                         
outbound_rule_keys      | List of rule keys to enable for outbound traffic                        
override_cidrs          | Map to override CIDRs for specific inbound rules                        
outbound_override_cidrs | Map to override CIDRs for specific outbound rules                       
override_source_sg_ids  | Map of rule keys to specific SG IDs (used instead of CIDRs for ingress) 


Outputs:
sg_id                   | The ID of the created security group