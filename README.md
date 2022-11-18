## ARJ-Stack: Azure Policy as a Framework - Terraform module

A Terraform module for configuring Azure Policy, Initiative (Policy Set) and Assignment of Policies and Initiatives.

### Resources
This module features the following components to be provisioned with different combinations:

- Azure Policy Definition [[azurerm_policy_definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition)]
- Azure Initiative (Policy Set) Definition [[azurerm_policy_set_definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition)]
- Management Group Scoped Policy/Initiative Assignment [[azurerm_management_group_policy_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment)]
- Subscription Scoped Policy/Initiative Assignment [[azurerm_subscription_policy_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment)]
- Resource group Scoped Policy/Initiative Assignment [[azurerm_resource_group_policy_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_assignment)]
- Resource Scoped Policy/Initiative Assignment [[azurerm_resource_policy_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_assignment)]
- ROle Assignments for Remediation [[azurerm_role_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment)]

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.14.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.14.0 |

### Examples

Refer [Configuration Examples](https://github.com/arjstack/terraform-azure-examples/tree/main/azure-policy) for effectively utilizing this module.

### Inputs
---

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="policies"></a> [policies](#policies) | List of Policies to be created | `any` |  | yes |
| <a name="initiatives"></a> [initiatives](#initiatives) | List of Initiatives to be created | `any` |  | yes |

### Nested Configuration Maps:  

#### policies

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="name"></a> [name](#input\_name) | The name of the policy definition. | `string` |  | yes |
| <a name="display_name"></a> [display_name](#input\_display\_name) | The display name of the policy definition. | `string` |  | no |
| <a name="description"></a> [description](#input\_description) | The description of the policy definition. | `string` |  | no |type
| <a name="type"></a> [name](#input\_type) | The policy type. | `string` | `Custom` | no |
| <a name="mode"></a> [mode](#input\_mode) | The policy resource manager mode that allows you to specify which resource types will be evaluated. | `string` | `All` | no |
| <a name="metadata"></a> [metadata](#input\_metadata) | The metadata for the policy definition. | `any` | <pre>{<br>   "category": "General"<br>   "version": "1.0.0"<br>} | no |
| <a name="policy_file"></a> [policy_file](#input\_policy\_file) | If need to provision, the policy file name with path, relative to root | `null` |  | no |
| <a name="assignments"></a> [assignments](#assignments) | List of Policy Assignments at the specified scopes. | `any` | `[]` | no |
| <a name="non_compliance_messages"></a> [non_compliance_messages](#input\_non\_compliance\_messages) | The Map of non-compliance message(s). | `map(string)` | `{}` | no |
| <a name="specific_role_definition_ids"></a> [specific_role_definition_ids](#input\_specific\_role\_definition\_ids) | The name of the policy definition. | `list(string)` | `[]` | no |

#### initiatives

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="name"></a> [name](#input\_name) | The name of the Initiative (policy set) definition. | `string` |  | yes |
| <a name="display_name"></a> [display_name](#input\_display\_name) | The display name of the Initiative (policy set) definition. | `string` |  | no |
| <a name="type"></a> [name](#input\_type) | The Initiative type. | `string` | `Custom` | no |
| <a name="description"></a> [description](#input\_description) | The description of the Initiative (policy set) definition. | `string` |  | no |
| <a name="custom_policies"></a> [custom_policies](#input\_custom\_policies) | List of Custom Policies (defined in `policies`) which should be part of Initiative | `any` | `[]` | no |
| <a name="builtin_policies"></a> [builtin_policies](#input\_builtin\_policies) | List of Azure Built-In or Already created Custom Policies which should be part of Initiative | `any` | `[]` | no |
| <a name="metadata"></a> [metadata](#input\_metadata) | The metadata for the policy definition. | `any` | <pre>{<br>   "category": "General"<br>   "version": "1.0.0"<br>} | no |
| <a name="assignments"></a> [assignments](#assignments) | List of Policy Assignments at the specified scopes. | `any` | `[]` | no |
| <a name="non_compliance_messages"></a> [non_compliance_messages](#input\_non\_compliance\_messages) | The Map of non-compliance message(s). | `map(string)` | `{}` | no |
| <a name="specific_role_definition_ids"></a> [specific_role_definition_ids](#input\_specific\_role\_definition\_ids) | The name of the policy definition. | `list(string)` | `[]` | no |

#### assignments

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="name"></a> [name](#input\_name) | The name of the Policy/Initiative Assignment.  | `string` |  | yes |
| <a name="display_name"></a> [display_name](#input\_display\_name) | A friendly display name to use for this Policy/Initiative Assignment. | `string` | `""` | no |
| <a name="description"></a> [description](#input\_description) | A description to use for this Policy/Initiative Assignment. | `string` | `""` | no |
| <a name="scope"></a> [scope](#input\_scope) | The Scope at which the Policy/Initiative Assignment should be applied, which must be a Resource ID | `string` |  | yes |
| <a name="not_scope"></a> [not_scope](#input\_not_scope) | A list of the Polic/Initiativey Assignment's excluded scopes. The list must contain Resource IDs | `list(string)` | `[]` | no |
| <a name="parameters"></a> [parameters](#input\_parameters) | Parameters for the policy/Initiative definition. | `any` | `{}` | no |
| <a name="metadata"></a> [metadata](#input\_metadata) | The metadata for the policy/Initiative assignment. | `map(string)` | `{}` | no |
| <a name="enforcement_mode"></a> [enforcement_mode](#input\_enforcement\_mode) | Can be set to 'true' or 'false' to control whether the assignment is enforced. | `bool` | `true` | no |
| <a name="location"></a> [location](#input\_location) | The Azure location where this policy/Initiative assignment should exist. | `string` | `null` | no |

### Outputs

| Name | Type | Description |
|:------|:------|:------|
| <a name="policies"></a> [policies](#input\_policies) |  `map(string)` | Map of The Definition IDs of the Custom Policies |
| <a name="initiatives"></a> [initiatives](#input\_initiatives) |  `map(string)` | Map of The Definition IDs of the Initiatives |

### Authors

Module is maintained by [Ankit Jain](https://github.com/ankit-jn) with help from [these professional](https://github.com/arjstack/terraform-azure-policy/graphs/contributors).