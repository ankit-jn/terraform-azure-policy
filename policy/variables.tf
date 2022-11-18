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
        error_message = "Policy name has a maximum 64 character limit."
    }
}

variable "display_name" {
    type        = string
    description = "The display name of the policy definition."

    validation {
        condition     = length(var.display_name) <= 128
        error_message = "Policy Display Name haa a maximum 128 character limit."
    }
}

variable "description" {
    type        = string
    description = "The description of the policy definition."
    default     = ""

    validation {
        condition     = length(var.description) <= 512
        error_message = "Policy description has a maximum 512 character limit."
    }
}

variable "type" {
    type        = string
    description = "The policy type."

    validation {
        condition     = contains(["BuiltIn", "Custom", "NotSpecified", "Static"], var.type)
        error_message = "Possible Values are `BuiltIn`, `Custom`, `NotSpecified `, `Static`."
    }
}

variable "mode" {
    type        = string
    description = "The policy resource manager mode that allows you to specify which resource types will be evaluated."
    
    validation {
        condition     = contains(["All", "Indexed", 
                                    "Microsoft.ContainerService.Data", 
                                    "Microsoft.CustomerLockbox.Data", 
                                    "Microsoft.DataCatalog.Data",
                                    "Microsoft.KeyVault.Data", 
                                    "Microsoft.Kubernetes.Data",
                                    "Microsoft.MachineLearningServices.Data",
                                    "Microsoft.Network.Data",
                                    "Microsoft.Synapse.Data"], var.mode)
        error_message = <<EOF
Possible Values are `All`, `Indexed`, 
`Microsoft.ContainerService.Data `, `Microsoft.CustomerLockbox.Data`, `Microsoft.DataCatalog.Data`,
`Microsoft.KeyVault.Data`, `Microsoft.Kubernetes.Data`, `Microsoft.MachineLearningServices.Data`,
`Microsoft.Network.Data`, `Microsoft.Synapse.Data`.
EOF
    }
}

variable "metadata" {
    type        = any
    description = "The metadata for the policy definition."
    default     = {
        "category": "General"
        "version": "1.0.0"
    }
}

variable "policy_file" {
    type        = string
    description = "Policy File name with path relative to Root."
}