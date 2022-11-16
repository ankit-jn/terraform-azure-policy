locals {
    # Filter Custom Policies and enrich the structure by reading policy json contents
    custom_policies = [for policy in var.policies: policy if lookup(policy, "policy_file", "") != "" ]

    custom_policy_def = { for name, policy in module.policies: name => policy.configuration }

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
                                                                local.custom_policy_def[policy]] 
                            assignments = try(initiative.assignments, [])
                            non_compliance_messages = try(initiative.non_compliance_messages, {})
                            role_definition_ids = try(initiative.role_definition_ids, [])
                            role_assignment_scope = try(initiative.role_assignment_scope, null)
                        }]

    # # For BuiltIn policies it reads the definition based on policy definition id if present in variable
    # builtin_policies = [ for policy in var.policies: 
    #                                         split("/", policy.definition_id)[length(split("/", policy.definition_id)) - 1] 
    #                                             if lookup(policy, "definition_id", "") != ""]

    # builtin_policy_def = [ 
    #     for def_name in toset(local.builtin_policies): {
    #         id          = data.azurerm_policy_definition.builtin[def_name].id
    #         name        = data.azurerm_policy_definition.builtin[def_name].name
    #         metadata    = can(data.azurerm_policy_definition.builtin[def_name].metadata) ? (
    #                                     jsonencode(data.azurerm_policy_definition.builtin[def_name].metadata)) : null
    #         parameters  = can(data.azurerm_policy_definition.builtin[def_name].parameters) ? (
    #                                     data.azurerm_policy_definition.builtin[def_name].parameters) : null
    #         policy_rule = can(data.azurerm_policy_definition.builtin[def_name].policy_rule) ? (
    #                                     data.azurerm_policy_definition.builtin[def_name].policy_rule) : null
    #     }
    # ]
}