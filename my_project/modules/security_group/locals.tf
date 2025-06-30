locals {
  selected_inbound_rules = {
    for rule_key in var.inbound_rule_keys : rule_key => merge(
      var.inbound_rules[rule_key],
      {
        cidr         = try(var.override_cidrs[rule_key], var.inbound_rules[rule_key].cidr)
        source_sg_id = try(var.override_source_sg_ids[rule_key], null)
      }
    )
  }

  selected_outbound_rules = {
    for rule_key in var.outbound_rule_keys : rule_key => merge(
      var.outbound_rules[rule_key],
      {
        cidr = try(var.outbound_override_cidrs[rule_key], var.outbound_rules[rule_key].cidr)
      }
    )
  }
}
