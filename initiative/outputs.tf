output "configuration" {
    description = "The Initiative resource node"
    value = {
        id                          = azurerm_policy_set_definition.this.id
        name                        = var.name
        display_name                = var.display_name
        description                 = var.description
        management_group_id         = var.management_group_id
        parameters                  = local.initiative_parameters
        metadata                    = try(jsondecode(var.metadata), {})
        policy_definition_reference = azurerm_policy_set_definition.this.policy_definition_reference
        role_definition_ids         = local.role_definition_ids
    }
}