output "policies" {
    description = "Map of The Definition IDs of the Custom Policies"
    value = { for name, policy in module.policies: name => policy.configuration.id }
}

output "initiatives" {
    description = "The Definition IDs of the Initiatives"
    value = { for name, initiative in module.initiatives: name => initiative.configuration.id }
}