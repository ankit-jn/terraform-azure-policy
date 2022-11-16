locals {
    
    identity_type = length(try(coalescelist(var.specific_role_definition_ids, try(var.policy_role_definition_ids, [])), [])) > 0 ? { type = "SystemAssigned" } : {}
    non_compliance_message = try(length(keys(var.non_compliance_messages)), 0) > 0 ? { 
                                    for reference_id, message in var.non_compliance_messages: 
                                            reference_id => message } : {}
    
    #### Initiative Assignments
    mg_assignments = { for assignment in var.assignments: 
                            assignment.scope => assignment 
                                    if length(regexall("(\\/managementGroups\\/)", assignment.scope)) > 0 }

    subscription_assignments = { for assignment in var.assignments: 
                            assignment.scope => assignment 
                                    if length(split("/", assignment.scope)) == 3 }

    rg_assignments = { for assignment in var.assignments: 
                            assignment.scope => assignment 
                                    if ((length(regexall("(\\/managementGroups\\/)", assignment.scope)) < 1) 
                                            && (length(split("/", assignment.scope)) == 5)) }

    resource_assignments = { for assignment in var.assignments: 
                            assignment.scope => assignment 
                                    if length(split("/", assignment.scope)) > 6 } 

    #### Role Assignment for Remediation
    mg_assigned_role = { for pair in setproduct(
                                        toset(var.policy_role_definition_ids), 
                                        keys(azurerm_management_group_policy_assignment.this)): "${pair[0]}-${pair[1]}" => pair }

    subscription_assigned_role = { for pair in setproduct(
                                                toset(var.policy_role_definition_ids), 
                                                keys(azurerm_subscription_policy_assignment.this)): "${pair[0]}-${pair[1]}" => pair }

    rg_assigned_role = { for pair in setproduct(
                                        toset(var.policy_role_definition_ids), 
                                        keys(azurerm_resource_group_policy_assignment.this)): "${pair[0]}-${pair[1]}" => pair }

    resource_assigned_role = { for pair in setproduct(
                                            toset(var.policy_role_definition_ids), 
                                            keys(azurerm_resource_policy_assignment.this)): "${pair[0]}-${pair[1]}" => pair }
           
}