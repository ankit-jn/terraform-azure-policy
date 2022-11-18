# Management Group Scoped Initiative Assignment
resource azurerm_management_group_policy_assignment "this" {

    for_each = local.mg_assignments

    policy_definition_id = var.policy_definition_id
    management_group_id  = each.value.scope
    not_scopes           = each.value.not_scopes

    name         = lower(coalesce(try(each.value.name, ""), var.policy_name))
    display_name = try(each.value.display_name, "")
    description  = try(each.value.description, "")
    metadata     = try(jsonencode(each.value.metadata), var.policy_metadata)
    
    enforce  = try(each.value.enforcement_mode, true)
    location = try(each.value.location, null)

    parameters = can(each.value.parameters) ? jsonencode({ for key, value in each.value.parameters: 
                                                                                key => { value = value } }) : null

    dynamic "non_compliance_message" {
        for_each = local.non_compliance_message
        content {
            policy_definition_reference_id = non_compliance_message.key
            content                        = non_compliance_message.value
        }
    }

    dynamic "identity" {
        for_each = local.identity_type
        content {
            type         = identity.value
            identity_ids = []
        }
    }
}


# Subscription Scoped Initiative Assignment
resource azurerm_subscription_policy_assignment "this" {

    for_each = local.subscription_assignments

    policy_definition_id = var.policy_definition_id
    subscription_id      = each.value.scope
    not_scopes           = each.value.not_scopes

    name         = lower(coalesce(try(each.value.name, ""), var.policy_name))
    display_name = try(each.value.display_name, "")
    description  = try(each.value.description, "")
    metadata     = try(jsonencode(each.value.metadata), var.policy_metadata)

    enforce  = try(each.value.enforcement_mode, true)
    location = try(each.value.location, null)

    parameters = can(each.value.parameters) ? jsonencode({ for key, value in each.value.parameters: 
                                                                                key => { value = value } }) : null

    dynamic "non_compliance_message" {
        for_each = local.non_compliance_message
        content {
            policy_definition_reference_id = non_compliance_message.key
            content                        = non_compliance_message.value
        }
    }

    dynamic "identity" {
        for_each = local.identity_type
        content {
            type         = identity.value
            identity_ids = []
        }
    }
}

# Resource Group Scoped Initiative Assignment
resource azurerm_resource_group_policy_assignment "this" {

    for_each = local.rg_assignments

    policy_definition_id = var.policy_definition_id
    resource_group_id    = each.value.scope
    not_scopes           = each.value.not_scopes

    name         = lower(coalesce(try(each.value.name, ""), var.policy_name))
    display_name = try(each.value.display_name, "")
    description  = try(each.value.description, "")
    metadata     = try(jsonencode(each.value.metadata), var.policy_metadata)

    enforce  = try(each.value.enforcement_mode, true)
    location = try(each.value.location, null)

    parameters = can(each.value.parameters) ? jsonencode({ for key, value in each.value.parameters: 
                                                                                key => { value = value } }) : null

    dynamic "non_compliance_message" {
        for_each = local.non_compliance_message
        content {
            policy_definition_reference_id = non_compliance_message.key
            content                        = non_compliance_message.value
        }
    }

    dynamic "identity" {
        for_each = local.identity_type
        content {
            type         = identity.value
            identity_ids = []
        }
    }
}

# Rsource Scoped Initiative Assignment
resource azurerm_resource_policy_assignment "this" {

    for_each = local.resource_assignments

    policy_definition_id = var.policy_definition_id
    resource_id          = each.value.scope
    not_scopes           = each.value.not_scopes

    name         = lower(coalesce(try(each.value.name, ""), var.policy_name))
    display_name = try(each.value.display_name, "")
    description  = try(each.value.description, "")
    metadata     = try(jsonencode(each.value.metadata), var.policy_metadata)

    enforce  = try(each.value.enforcement_mode, true)
    location = try(each.value.location, null)

    parameters = can(each.value.parameters) ? jsonencode({ for key, value in each.value.parameters: 
                                                                                key => { value = value } }) : null

    dynamic "non_compliance_message" {
        for_each = local.non_compliance_message
        content {
            policy_definition_reference_id = non_compliance_message.key
            content                        = non_compliance_message.value
        }
    }

    dynamic "identity" {
        for_each = local.identity_type
        content {
            type         = identity.value
            identity_ids = []
        }
    }
}