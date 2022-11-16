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

    assignments = each.value.assignments
    role_definition_ids = each.value.role_definition_ids
    non_compliance_messages = each.value.non_compliance_messages
}