terraform {
  required_version = ">=0.13"
  required_providers {
    scalr = {
      source  = "registry.scalr.io/scalr/scalr"
      version = "1.0.0-rc28"

    }
  }
}

resource "scalr_workspace" "workspaces" {
  name              = var.name
  environment_id    = var.environment_id
  auto_apply        = var.auto_apply
  operations        = var.operations
  terraform_version = var.terraform_version
  working_directory = var.working_directory
  vcs_provider_id   = var.vcs_provider_id
  agent_pool_id     = var.agent_pool_id
  # run_operation_timeout = var.run_operation_timeout - Not working, provider bug?

  dynamic "vcs_repo" {
    for_each = var.vcs_repo
    content {
      identifier       = vcs_repo.value.identifier
      branch           = vcs_repo.value.branch
      path             = vcs_repo.value.path
      trigger_prefixes = vcs_repo.value.trigger_prefixes
      dry_runs_enabled = vcs_repo.value.dry_runs_enabled
    }
  }

  dynamic "hooks" {
    for_each = var.hooks
    content {
      pre_plan   = hooks.value.pre_plan
      post_plan  = hooks.value.post_plan
      pre_apply  = hooks.value.pre_apply
      post_apply = hooks.value.post_apply
    }
  }
}
