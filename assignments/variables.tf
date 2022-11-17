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
    description = "List of Assignments"
    type        = any
}

variable "policy_metadata" {
    description = "The metadata for the policy/Initiative definition."
    type        = any
    default     = null
}

variable specific_role_definition_ids {
    description = "Explicit roles to be assigned for Remediation"
    type = list(string)
}

variable policy_role_definition_ids {
    description = "Policy roles (as per Policy/Initiative Definition) to be assgined for Remediation"
    type = list(string)
}

variable non_compliance_messages {
    description = "(Optional) The Map of non-compliance message(s)"
    type        = any
}