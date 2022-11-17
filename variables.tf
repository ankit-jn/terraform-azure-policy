variable policies {
    description = <<EOF
List of Policies to be created where each entry would be a map of following key pairs:

name: (Required) The name of the policy definition.
description: (Optional) The description of the policy definition.
policy_file: (Optional) If need to provision, the policy file name with path, relative to root
assignments: List of Policy Assignments at the specified scopes. The structure of the assignment is as follws:
    name: (Required) The name of the Policy Assignment. 
    display_name: (Optional) A friendly display name to use for this Policy Assignment.
    description: (Optional) A description to use for this Policy Assignment.
    scope: (Required) The Scope at which the Policy Assignment should be applied, which must be a Resource ID
    not_scope: (Optional) A list of the Policy Assignment's excluded scopes. The list must contain Resource IDs
    parameters: (Optional) Parameters for the policy definition.
    metadata: (Optional) The metadata for the policy assignment.
    enforcement_mode: (Optional) Can be set to 'true' or 'false' to control whether the assignment is enforced
    location: (Optional) The Azure location where this policy assignment should exist.
non_compliance_messages: (Optional) The Map of non-compliance message(s)
specific_role_definition_ids: List of Explicit Role definition ID, used in Role assignments for Remediation
EOF
    type        = any
    default     = []
}

variable initiatives {
    description = <<EOF
List of Initiatives to be created where each entry would be a map of following key pairs:

name: (Required) The name of the Initiative (policy set) definition.
display_name: (Optional) The display name of the Initiative (policy set) definition.
description: (Optional) The description of the Initiative (policy set) definition.
custom_policies: (Optional) List of Custom Policies (defined in `policies`) which should be part of Initiative
builtin_policies: (Optional) List of Azure Built-In or Already created Custom Policies which should be part of Initiative
assignments: List of Policy Assignments at the specified scopes. The structure of the assignment is as follws:
    name: (Required) The name of the Policy/Initiative Assignment. 
    display_name: (Optional) A friendly display name to use for this Policy/Initiative Assignment.
    description: (Optional) A description to use for this Policy/Initiative Assignment.
    scope: (Required) The Scope at which the Policy/Initiative Assignment should be applied, which must be a Resource ID
    not_scope: (Optional) A list of the Polic/Initiativey Assignment's excluded scopes. The list must contain Resource IDs
    parameters: (Optional) Parameters for the policy/Initiative definition.
    metadata: (Optional) The metadata for the policy/Initiative assignment.
    enforcement_mode: (Optional) Can be set to 'true' or 'false' to control whether the assignment is enforced.
    location: (Optional) The Azure location where this policy/Initiative assignment should exist.
non_compliance_messages: The Map of non-compliance message(s).
specific_role_definition_ids: List of Role definition ID, used in Role assignments for Remediation
EOF
    type        = any
    default     = []
}

variable management_group_id {
    type        = string
    description = <<EOF
The management group scope at which the Policy/Initiative will be defined. 
Defaults to current Subscription if omitted.
EOF
    default     = null
}