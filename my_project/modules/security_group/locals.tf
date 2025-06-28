locals {
  common_tags = {
    env = "prod"
    by  = "terraform"
  }
}

locals {
  selected_inbound_rules = {
    for key in var.inbound_rule_keys : key => merge(
      var.inbound_rules[key],
      {
        cidr = lookup(var.override_cidrs, key, var.inbound_rules[key].cidr)
      }
    )
  }
}

locals {
  selected_outbound_rules = {
    for key in var.outbound_rule_keys : key => merge(
      var.outbound_rules[key],
      {
        cidr = lookup(var.outbound_override_cidrs, key, var.outbound_rules[key].cidr)
      }
    )
  }
}
