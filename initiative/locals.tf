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
                            replace(title(replace(name, "/-|_|\\s/", " ")), "/\\s/", ""), 
                            parameter_name) => parameter_value
            } if parameters != null
    })...)

    # Role definition IDs
    policy_role_definition_ids = { for policy_config in local.policy_configs :
                                    policy_config.name => try(jsondecode(policy_config.policy_rule).then.details.roleDefinitionIds, [])}
    role_definition_ids = try(distinct([for v in flatten(values(local.policy_role_definition_ids)) : lower(v)]), [])

    identity_type = length(try(coalescelist(var.role_definition_ids, try(local.role_definition_ids, [])), [])) > 0 ? { type = "SystemAssigned" } : {}
    non_compliance_message = try(length(keys(var.non_compliance_messages)), 0) > 0 ? { 
                                    for reference_id, message in var.non_compliance_messages: 
                                            reference_id => message } : {}
    
    #### Initiative Assignments
    mg_assignments = { for assignment in var.assignments: 
                            assignment.scope => assignment 
                                    if length(regexall("(\\/managementGroups\\/)", assignment.scope)) > 0 }

    subscription_assignments = { for assignment in var.assignments: 
                            assignment.scope => assignment 
                                    if length(split("/", assignment.scope)) == 3 }

    rg_assignments = { for assignment in var.assignments: 
                            assignment.scope => assignment 
                                    if ((length(regexall("(\\/managementGroups\\/)", assignment.scope)) < 1) 
                                            && (length(split("/", assignment.scope)) == 5)) }

    resource_assignments = { for assignment in var.assignments: 
                            assignment.scope => assignment 
                                    if length(split("/", assignment.scope)) > 6 } 

    #### Role Assignment for Remediation
    mg_assigned_role = { for pair in setproduct(
                                        toset(local.role_definition_ids), 
                                        keys(azurerm_management_group_policy_assignment.this)): "${pair[0]}-${pair[1]}" => pair }

    subscription_assigned_role = { for pair in setproduct(
                                                toset(local.role_definition_ids), 
                                                keys(azurerm_subscription_policy_assignment.this)): "${pair[0]}-${pair[1]}" => pair }

    rg_assigned_role = { for pair in setproduct(
                                        toset(local.role_definition_ids), 
                                        keys(azurerm_resource_group_policy_assignment.this)): "${pair[0]}-${pair[1]}" => pair }

    resource_assigned_role = { for pair in setproduct(
                                            toset(local.role_definition_ids), 
                                            keys(azurerm_resource_policy_assignment.this)): "${pair[0]}-${pair[1]}" => pair }
           
}