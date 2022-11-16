variable "management_group_id" {
    description = "The management group scope at which the initiative will be defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created. Note: if you are using azurerm_management_group to assign a value to management_group_id, be sure to use name or group_id attribute, but not id."
    type        = string
}

variable "name" {
    description = "The name of the policy set definition (Initiative)."
    type        = string

    validation {
        condition     = length(var.name) <= 64
        error_message = "Initiative names have a maximum 64 character limit."
    }
}

variable "display_name" {
    description = "The display name of the policy set definition (Initiative)."
    type        = string

    validation {
        condition     = length(var.display_name) <= 128
        error_message = "Initiative display names have a maximum 128 character limit."
    }
}

variable "description" {
    description = "The description of the policy set definition (Initiative)."
    type        = string

    validation {
        condition     = length(var.description) <= 512
        error_message = "Initiative descriptions have a maximum 512 character limit."
    }
}

variable "metadata" {
    description = "The metadata for the policy set definition."
    type        = any
    default     = null
}

variable "custom_policies" {
    description = "Custom Policies which shold be added in the Initiative."
    type        = any
}

variable "builtin_policies" {
    description = "BuiltIn Policies which shold be added in the Initiative."
    type        = any
}

variable assignments {
    description = "Initiaive assignments"
    type        = any
}

variable role_definition_ids {
    description = "Explicit roles to be used for Remediation"
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