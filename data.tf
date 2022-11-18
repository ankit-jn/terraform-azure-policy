data azurerm_policy_definition "this" {
    for_each = { for policy in local.builtin_policies: policy => policy }

    name = each.value
}