# Management Group Scoped Initiative Role Assignment for Remediation
resource azurerm_role_assignment "rem_role_mg" {
    for_each = local.mg_assigned_role

    scope              = coalesce(var.role_assignment_scope, 
                                        azurerm_management_group_policy_assignment.this[each.value[1]].management_group_id)
    role_definition_id = each.value[0]
    principal_id       = azurerm_management_group_policy_assignment.this[each.value[1]].identity[0].principal_id
    
    skip_service_principal_aad_check = true
}


# Subscription Scoped Initiative Role Assignment for Remediation
resource azurerm_role_assignment "rem_role_subscription" {
    for_each = local.subscription_assigned_role

    scope              = coalesce(var.role_assignment_scope, 
                                        azurerm_subscription_policy_assignment.this[each.value[1]].subscription_id)
    role_definition_id = each.value[0]
    principal_id       = azurerm_subscription_policy_assignment.this[each.value[1]].identity[0].principal_id
    
    skip_service_principal_aad_check = true
}

# Resource Group Scoped Initiative Role Assignment for Remediation
resource azurerm_role_assignment "rem_role_rg" {
    for_each = local.rg_assigned_role

    scope              = coalesce(var.role_assignment_scope, 
                                        azurerm_resource_group_policy_assignment.this[each.value[1]].resource_group_id)
    role_definition_id = each.value[0]
    principal_id       = azurerm_resource_group_policy_assignment.this[each.value[1]].identity[0].principal_id
    
    skip_service_principal_aad_check = true
}

# Resource Scoped Initiative Role Assignment for Remediation
resource azurerm_role_assignment "rem_role_resource" {
    for_each = local.resource_assigned_role

    scope              = coalesce(var.role_assignment_scope, 
                                        azurerm_resource_policy_assignment.this[each.value[1]].resource_id)
    role_definition_id = each.value[0]
    principal_id       = azurerm_resource_policy_assignment.this[each.value[1]].identity[0].principal_id
    
    skip_service_principal_aad_check = true
}