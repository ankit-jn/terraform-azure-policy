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

variable "type" {
    type        = string
    description = "The Initiative type."

    validation {
        condition     = contains(["BuiltIn", "Custom", "NotSpecified", "Static"], var.type)
        error_message = "Possible Values are `BuiltIn`, `Custom`, `NotSpecified `, `Static`."
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
    type        = any
    description = "The metadata for the policy set definition."
    default     = {
        "category": "General"
        "version": "1.0.0"
    }
}

variable "custom_policies" {
    description = "Custom Policies which shold be added in the Initiative."
    type        = any
}

variable "builtin_policies" {
    description = "BuiltIn Policies which shold be added in the Initiative."
    type        = any
}