output "alb_dns" {
  value = module.alb.alb_dns_name
}

output "public_subnet_ids" {
  value = module.vpc.subnet
}

output "asg_name" {
  value = module.launch_template_instance_asg.asg_name
}