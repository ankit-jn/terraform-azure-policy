variable "policy_definition_id" {
    description = "The Definition ID of the Initiative/Policy"
    type        = string
}

variable "policy_name" {
    description = "The name of the Initiative/Policy."
    type        = string

    validation {
        condition     = length(var.policy_name) <= 64
        error_message = "Initiative/Policy names have a maximum 64 character limit."
    }
}

variable assignments {
    description = "Initiaive assignments"
    type        = any
}

variable "metadata" {
    description = "The metadata for the policy set definition."
    type        = any
    default     = null
}

variable specific_role_definition_ids {
    description = "Explicit roles to be used for Remediation"
    type = list(string)
}

variable policy_role_definition_ids {
    description = "Policy roles to be used for Remediation"
    type = list(string)
}

variable non_compliance_messages {
    description = "The optional non-compliance message(s). Key/Value pairs map as policy_definition_reference_id = 'content', use null = 'content' to specify the Default non-compliance message for all member definitions."    
    type        = any
}

variable role_assignment_scope {
    description = "The scope at which role definition(s) will be assigned, defaults to Policy Assignment Scope. Must be full resource IDs. Changing this forces a new resource to be created"
    type        = string
    default     = null
}