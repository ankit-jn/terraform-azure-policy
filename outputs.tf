output "policies" {
    description = "Map of the configurations for the Custom Policies"
    value = { for name, policy in module.policies: name => policy.configuration }
}

output "initiatives" {
    description = "Map of the configurations of the Initiatives"
    value = { for name, initiative in module.initiatives: name => initiative.configuration }
}