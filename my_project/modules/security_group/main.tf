resource "aws_security_group" "allow_tls" {
  name   = var.sg_name
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ingress" {
  for_each = local.selected_inbound_rules

  type      = "ingress"
  from_port = each.value.from_port
  to_port   = each.value.to_port
  protocol  = each.value.protocol

  cidr_blocks = (
    try(each.value.source_sg_id, null) == null ?
    [for cidr in each.value.cidr : cidr if can(regex("^\\d+\\.\\d+\\.\\d+\\.\\d+/\\d+", cidr))] :
    null
  )

  ipv6_cidr_blocks = (
    try(each.value.source_sg_id, null) == null ?
    [for cidr in each.value.cidr : cidr if can(regex("^::", cidr))] :
    null
  )

  security_group_id        = aws_security_group.allow_tls.id
  description              = "Rule ${each.key}"
  source_security_group_id = try(each.value.source_sg_id, null)
}

resource "aws_security_group_rule" "egress" {
  for_each = local.selected_outbound_rules

  type             = "egress"
  from_port        = each.value.from_port
  to_port          = each.value.to_port
  protocol         = each.value.protocol
  cidr_blocks      = [for cidr in each.value.cidr : cidr if can(regex("^\\d+\\.\\d+\\.\\d+\\.\\d+/\\d+", cidr))]
  ipv6_cidr_blocks = [for cidr in each.value.cidr : cidr if can(regex("^::", cidr))]

  security_group_id = aws_security_group.allow_tls.id
  description       = "Rule ${each.key}"
}
