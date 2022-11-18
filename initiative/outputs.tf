output "configuration" {
    description = "The Initiative Details"
    value = {
        id                          = azurerm_policy_set_definition.this.id
        parameters                  = local.initiative_parameters
        metadata                    = try(jsondecode(var.metadata), null)
        policy_definition_reference = azurerm_policy_set_definition.this.policy_definition_reference
        role_definition_ids         = local.role_definition_ids
    }
}