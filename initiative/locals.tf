locals {

    # For BuiltIn policies it reads the definition based on policy definition id if present in variable
    builtin_policy_configs = [ 
        for policy in toset(var.builtin_policies) :
        {
            id                  = data.azurerm_policy_definition.this[policy].id
            name                = data.azurerm_policy_definition.this[policy].name
            metadata            = can(data.azurerm_policy_definition.this[policy].metadata) ? jsonencode(data.azurerm_policy_definition.this[policy].metadata) : null
            parameters          = can(data.azurerm_policy_definition.this[policy].parameters) ? data.azurerm_policy_definition.this[policy].parameters : null
            policy_rule         = can(data.azurerm_policy_definition.this[policy].policy_rule) ? data.azurerm_policy_definition.this[policy].policy_rule : null
        }
    ]

    policy_configs = concat(local.builtin_policy_configs, var.custom_policies)

    # colate all definition parameters into a single object
    policy_parameters = { for policy_config in local.policy_configs : policy_config.name => try(jsondecode(policy_config.parameters), null) }

    # combine all discovered definition parameters with definition references   
    initiative_parameters = merge(values({
        for name, parameters in local.policy_parameters :
            name => {
                for parameter_name, parameter_value in parameters :
                    format("%s_%s", 
                            replace(replace(name, "/\\s/", " "), "/\\s/", ""), 
                            parameter_name) => parameter_value
            } if parameters != null
    })...)

    # Role definition IDs
    policy_role_definition_ids = { for policy_config in local.policy_configs :
                                    policy_config.name => try(jsondecode(policy_config.policy_rule).then.details.roleDefinitionIds, [])}
    role_definition_ids = try(distinct([for v in flatten(values(local.policy_role_definition_ids)) : lower(v)]), [])
           
}