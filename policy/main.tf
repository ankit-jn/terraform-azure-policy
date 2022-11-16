resource azurerm_policy_definition "this" {
    name         = var.name
    description  = var.description
    
    policy_type  = lookup(local.policyjson.properties, "policyType", null)
    mode         = lookup(local.policyjson.properties, "mode", null)
    display_name = lookup(local.policyjson.properties, "display_name", "")

    management_group_id = var.management_group_id

    metadata = <<METADATA
{
  "category": "${local.policyjson.properties.metadata.category}"
}
METADATA

    parameters  = can(local.policyjson.properties.parameters) ? jsonencode(local.policyjson.properties.parameters) : null
    policy_rule = jsonencode(local.policyjson.properties.policyRule)
}