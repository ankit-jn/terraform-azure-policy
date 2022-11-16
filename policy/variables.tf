variable "management_group_id" {
    type        = string
    description = "The management group scope at which the Policy will be defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created. Note: if you are using azurerm_management_group to assign a value to management_group_id, be sure to use name or group_id attribute, but not id."
    default     = null
}

variable "name" {
    type        = string
    description = "The name of the policy definition."

    validation {
        condition     = length(var.name) <= 64
        error_message = "Policy names have a maximum 64 character limit."
    }
}

variable "description" {
    type        = string
    description = "The description of the policy definition."

    validation {
        condition     = length(var.description) <= 512
        error_message = "Initiative descriptions have a maximum 512 character limit."
    }
}

variable "policy_file" {
    type        = string
    description = "Policy File name with path relative to Root."
}