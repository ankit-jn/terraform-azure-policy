locals {
    ################################
    ## Policy Provisioning
    ################################

    # Filter Custom Policies to be provisioned
    custom_policies = [for policy in var.policies: policy if lookup(policy, "policy_file", "") != "" ]
    custom_policy_configs = { for name, policy in module.policies: name => policy.configuration }

    ################################
    ## Policy Assignments
    ################################

    ## Filter BuiltIn policies and read the definition
    builtin_policies = [ for policy in var.policies: policy.name 
                                                if (lookup(policy, "policy_file", "") == ""
                                                     && length(try(policy.assignments, [])) > 0) ]
    
    ## In memory presentation of BuiltIn Policy configuration
    builtin_policy_configs = {
        for policy in toset(local.builtin_policies) :
        policy => {
            id                  = data.azurerm_policy_definition.this[policy].id
            name                = data.azurerm_policy_definition.this[policy].name
            metadata            = try(jsonencode(data.azurerm_policy_definition.this[policy].metadata), null)
            policy_rule         = try(data.azurerm_policy_definition.this[policy].policy_rule, null)
            role_definition_ids = try(jsondecode(data.azurerm_policy_definition.this[policy].policy_rule).then.details.roleDefinitionIds, [])
        }}

    ## In memory presentation of Assignment for Custom Policies
    custom_policy_assignments = [ for policy in var.policies: {
                                                    id = module.policies[policy.name].configuration.id
                                                    name = policy.name
                                                    assignments = try(policy.assignments, [])
                                                    metadata = module.policies[policy.name].configuration.metadata
                                                    non_compliance_messages = try(policy.non_compliance_messages, {})
                                                    specific_role_definition_ids = try(policy.role_definition_ids, [])
                                                    policy_role_definition_ids = module.policies[policy.name].configuration.role_definition_ids
                                                    role_assignment_scope = try(policy.role_assignment_scope, null)
                                                } if (lookup(policy, "policy_file", "") != ""
                                                        && length(try(policy.assignments, [])) > 0) ]

    ## In memory presentation of Assignment for BuiltIn Policies
    builtin_policy_assignments = [ for policy in local.builtin_policies: {
                                                    id = local.builtin_policy_configs[policy].id
                                                    name = policy
                                                    assignments = policy.assignments
                                                    metadata = local.builtin_policy_configs[policy].metadata
                                                    non_compliance_messages = try(policy.non_compliance_messages, {})
                                                    specific_role_definition_ids = try(policy.role_definition_ids, [])
                                                    policy_role_definition_ids = local.builtin_policy_configs[policy].role_definition_ids
                                                    role_assignment_scope = try(policy.role_assignment_scope, null)
                                                } if (lookup(policy, "policy_file", "") == ""
                                                        && length(try(policy.assignments, [])) > 0)]

    ## Compacted the Assignment of Polices
    policy_assignments = concat(local.builtin_policy_assignments, local.custom_policy_assignments)

    ################################
    ## Initiatives
    ################################
    initiatives = [ for initiative in var.initiatives: {
                            management_group_id = var.management_group_id
                            name = initiative.name
                            display_name = lookup(initiative, "display_name", "")
                            description = lookup(initiative, "description", "")
                            category = lookup(initiative, "category", "General")
                            initiative_version = lookup(initiative, "initiative_version", "1.0.0")
                            metadata = lookup(initiative, "metadata", null)
                            builtin_policies = try(initiative.builtin_policies, [])
                            custom_policies = [for policy in initiative.custom_policies: 
                                                                local.custom_policy_configs[policy]] 
                        }]
    
    ################################
    ## Initiatives Assignments
    ################################
    initiatives_assignments = [ for initiative in var.initiatives: {
                            id = module.initiatives[initiative.name].configuration.id
                            name = initiative.name
                            metadata = module.initiatives[initiative.name].configuration.metadata
                            assignments = try(initiative.assignments, [])
                            non_compliance_messages = try(initiative.non_compliance_messages, {})
                            specific_role_definition_ids = try(initiative.role_definition_ids, [])
                            policy_role_definition_ids = module.initiatives[initiative.name].configuration.role_definition_ids
                            role_assignment_scope = try(initiative.role_assignment_scope, null)                        
                        }]

}