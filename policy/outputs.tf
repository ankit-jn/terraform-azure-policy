output "configuration" {
    description = "policy Details"
    value = {
                id          = azurerm_policy_definition.this.id
                name        = azurerm_policy_definition.this.name
                metadata    = try(jsondecode(azurerm_policy_definition.this.metadata), null)
                parameters  = azurerm_policy_definition.this.parameters
                role_definition_ids = try(jsondecode(azurerm_policy_definition.this.policy_rule).then.details.roleDefinitionIds, [])
            }
}