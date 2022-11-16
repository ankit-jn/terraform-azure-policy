module "policies" {
    source = "./policy"

    for_each = { for policy in local.custom_policies: policy.name => policy }

    name = each.value.name
    description = try(each.value.description, "")
    policy_file = each.value.policy_file

    management_group_id = var.management_group_id
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

    for_each = { for initiative in local.initiatives: initiative.name => initiative }

    policy_definition_id = module.initiatives[each.key].configuration.id
    policy_name = module.initiatives[each.key].configuration.name

    assignments = try(each.value.assignments, [])
    
    metadata = each.value.metadata
    non_compliance_messages = try(each.value.non_compliance_messages, {})
    
    specific_role_definition_ids = try(each.value.role_definition_ids, [])
    policy_role_definition_ids = module.initiatives[each.key].configuration.role_definition_ids
    
    role_assignment_scope = try(each.value.role_assignment_scope, null)
}