output "configuration" {
    value = {
                id          = azurerm_policy_definition.this.id
                name        = azurerm_policy_definition.this.name
                metadata    = jsonencode(azurerm_policy_definition.this.metadata)
                parameters  = can(azurerm_policy_definition.this.parameters) ? azurerm_policy_definition.this.parameters : null
                policy_rule = can(azurerm_policy_definition.this.policy_rule)? azurerm_policy_definition.this.policy_rule : null
                role_definition_ids = try(jsondecode(azurerm_policy_definition.this.policy_rule).then.details.roleDefinitionIds, [])
            }
}