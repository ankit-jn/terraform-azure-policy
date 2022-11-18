output "configuration" {
    value = {
                id          = azurerm_policy_definition.this.id
                name        = azurerm_policy_definition.this.name
                metadata    = try(jsondecode(azurerm_policy_definition.this.metadata), null)
                parameters  = azurerm_policy_definition.this.parameters
                policy_rule = azurerm_policy_definition.this.policy_rule
                role_definition_ids = try(jsondecode(azurerm_policy_definition.this.policy_rule).then.details.roleDefinitionIds, [])
            }
}