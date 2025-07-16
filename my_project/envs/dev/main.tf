module "vpc" {
  source             = "../../modules/vpc"
  vpc_name           = var.vpc_name
  vpc_cidr           = var.vpc_cidr
  igw_name           = var.igw_name
  public_rt_name     = var.public_rt_name
  public_subnet_name = var.public_subnet_name
  subnet_count       = var.subnet_count
  tags               = local.common_tags
}

module "alb_sg" {
  source = "../../modules/security_group"

  vpc_id  = module.vpc.vpc
  sg_name = var.sg_name.lb

  inbound_rule_keys = ["http", "https"]
  override_cidrs = {
    http  = ["0.0.0.0/0"]
    https = ["0.0.0.0/0"]
  }
  override_source_sg_ids = {}
  outbound_rule_keys     = ["all_traffic"]
  outbound_override_cidrs = {
    all_traffic = ["0.0.0.0/0"]
  }
}

module "ec2_sg" {
  source = "../../modules/security_group"

  vpc_id  = module.vpc.vpc
  sg_name = var.sg_name.ec2

  inbound_rule_keys = ["http", "ssh"]
  override_cidrs = {
    http = []
    ssh  = ["0.0.0.0/0"]
  }

  override_source_sg_ids = {
    http = module.alb_sg.sg_id
  }
  outbound_rule_keys = ["all_traffic"]
  outbound_override_cidrs = {
    all_traffic = ["0.0.0.0/0"]
  }
}

module "alb" {
  source   = "../../modules/alb"
  lb_name  = var.lb_name
  internal = var.internal
  lb_type  = var.lb_type
  tg_name  = var.tg_name

  vpc_id            = module.vpc.vpc
  vpc_cidr          = var.vpc_cidr
  security_group_id = module.alb_sg.sg_id
  subnet            = module.vpc.subnet

  tags = local.common_tags

}
module "launch_template_instance_asg" {
  source = "../../modules/launch_template_instance_asg"

  launch_template_name = var.launch_template_name
  instance_name        = var.instance_name
  user_data_file  = "${path.root}/install_nginx.sh"

  tags                 = local.common_tags

  security_group_id = module.ec2_sg.sg_id

  subnet = module.vpc.subnet

  asg_name         = var.asg_name
  scaling_size     = var.scaling_size
  target_group_arn = [module.alb.target_group_arn]
  ami_id           = var.ami_id

}
