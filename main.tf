module "policies" {
    source = "./policy"

    for_each = { for policy in local.custom_policies: policy.name => policy }

    name = each.value.name
    description = try(each.value.description, "")
    policy_file = each.value.policy_file

    management_group_id = var.management_group_id
}

module "policies_assignments" {
    source = "./assignments"

    for_each = { for policy in local.policy_assignments: policy.name => policy }

    policy_definition_id = each.value.id
    policy_name = each.key

    assignments = try(each.value.assignments, [])
    
    metadata = lookup(each.value, "metadata", null)
    non_compliance_messages = each.value.non_compliance_messages
    
    specific_role_definition_ids = each.value.specific_role_definition_ids
    policy_role_definition_ids = each.value.policy_role_definition_ids
    
    role_assignment_scope = each.value.role_assignment_scope
}

module "initiatives" {
    source = "./initiative"

    for_each = { for initiative in local.initiatives: initiative.name => initiative }

    management_group_id = var.management_group_id
    name = each.value.name
    display_name = each.value.display_name
    description = each.value.description
    
    metadata = each.value.metadata
    
    custom_policies = each.value.custom_policies
    builtin_policies = each.value.builtin_policies
}

module "initiatives_assignments" {
    source = "./assignments"

    for_each = { for initiative in local.initiatives_assignments: initiative.name => initiative }

    policy_definition_id = each.value.id
    policy_name = each.key

    assignments = try(each.value.assignments, [])
    
    metadata = each.value.metadata
    non_compliance_messages = each.value.non_compliance_messages
    
    specific_role_definition_ids = each.value.specific_role_definition_ids
    policy_role_definition_ids = each.value.policy_role_definition_ids
    
    role_assignment_scope = each.value.role_assignment_scope
}