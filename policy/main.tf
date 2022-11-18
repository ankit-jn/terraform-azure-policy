resource azurerm_policy_definition "this" {
    name         = var.name
    display_name = coalesce(var.display_name, var.name)
    description  = var.description
    
    policy_type  = var.type
    mode         = var.mode

    management_group_id = var.management_group_id

    metadata = try(jsonencode(var.metadata), null)

    parameters  = try(jsonencode(local.policyjson.properties.parameters), null)
    policy_rule = jsonencode(local.policyjson.properties.policyRule)
}