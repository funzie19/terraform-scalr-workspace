variable "environment_id" {
  description = "Environment which workspace will be created in."
}

variable "name" {
  description = "Workspace name."
}

variable "auto_apply" {
  default     = "false"
  description = "Auto apply on successful plan."
}

variable "operations" {
  default     = "true"
  description = "Set to configure workspace remote execution in CLI-driven mode."
}

variable "terraform_version" {
  default = "0.13.0"
}

variable "working_directory" {
  default     = ""
  description = "A relative path that Terraform will be run in."
}

variable "run_operation_timeout" {
  default     = "0"
  description = "The number of minutes run operation can be executed before termination."
}

variable "agent_pool_id" {
  default     = ""
  description = "The identifier of an agent pool."
}

variable "vcs_provider_id" {
  default     = ""
  description = "ID of vcs provider"
}

variable "vcs_repo" {
  default = []
}

variable "hooks" {
  default = []
}
