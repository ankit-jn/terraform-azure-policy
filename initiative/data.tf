data azurerm_policy_definition "this" {
    for_each = { for policy in var.builtin_policies: policy => policy }

    name     = each.value
}