resource azurerm_policy_set_definition "this" {
    name         = var.name
    display_name = coalesce(var.display_name, var.name)
    description  = var.description
    policy_type  = "Custom"
    
    management_group_id = var.management_group_id

    metadata   = jsonencode(var.metadata)
    parameters = jsonencode(local.initiative_parameters)

    dynamic policy_definition_reference {
        for_each = [for policy_config in local.policy_configs : {
            id         = policy_config.id
            ref_id     = replace(title(replace(policy_config.name, "/-|_|\\s/", " ")), "/\\s/", "")
            parameters = try(jsondecode(policy_config.parameters), "")
            groups     = []
        }]

        content {
            policy_definition_id = policy_definition_reference.value.id
            reference_id         = policy_definition_reference.value.ref_id
            parameter_values = try(jsonencode({
            for k in keys(policy_definition_reference.value.parameters) :
                k => { value = "[parameters('${format("%s_%s", policy_definition_reference.value.ref_id, k)}')]" }
            }), "")
            policy_group_names = policy_definition_reference.value.groups
        }
    }

    timeouts {
        read = "10m"
    }
}