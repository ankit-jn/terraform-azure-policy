variable policies {
    description = "List of Policies to be created."
    type        = any
    default     = []
}

variable initiatives {
    description = "List of Initiatives to be created."
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