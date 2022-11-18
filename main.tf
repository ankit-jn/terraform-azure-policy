module "policies" {
    source = "./policy"

    for_each = { for policy in local.custom_policies: policy.name => policy }

    name = each.value.name
    display_name = try(each.value.display_name, "")
    description = try(each.value.description, "")

    type = try(each.value.type, "Custom")
    mode = try(each.value.mode, "All")
    metadata = try(each.value.metadata, null)
    
    policy_file = each.value.policy_file

    management_group_id = var.management_group_id
}

module "policy_assignments" {
    source = "./assignments"

    for_each = { for policy in local.policy_assignments: policy.name => policy }

    policy_definition_id = each.value.id
    policy_name = each.key

    assignments = try(each.value.assignments, [])
    
    policy_metadata = each.value.metadata
    non_compliance_messages = each.value.non_compliance_messages
    
    specific_role_definition_ids = each.value.specific_role_definition_ids
    policy_role_definition_ids = each.value.policy_role_definition_ids
}

module "initiatives" {
    source = "./initiative"

    for_each = { for initiative in local.initiatives: initiative.name => initiative }

    management_group_id = var.management_group_id
    name = each.value.name
    display_name = each.value.display_name
    
    type = each.value.type
    
    description = each.value.description
    
    metadata = each.value.metadata
    
    custom_policies = each.value.custom_policies
    builtin_policies = each.value.builtin_policies
}

module "initiative_assignments" {
    source = "./assignments"

    for_each = { for initiative in local.initiatives_assignments: initiative.name => initiative }

    policy_definition_id = each.value.id
    policy_name = each.key

    assignments = try(each.value.assignments, [])
    
    policy_metadata = each.value.metadata
    non_compliance_messages = each.value.non_compliance_messages
    
    specific_role_definition_ids = each.value.specific_role_definition_ids
    policy_role_definition_ids = each.value.policy_role_definition_ids
}