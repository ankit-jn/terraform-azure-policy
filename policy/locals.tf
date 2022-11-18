locals {
   policyjson = jsondecode(file("${path.root}/${var.policy_file}"))
}