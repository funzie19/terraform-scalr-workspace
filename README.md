# terraform-scalr-workspace
Module to create and manage one or multiple workspaces.


## Using the module
### Compatibility
- [Terraform](https://www.terraform.io/downloads.html) >= 0.13.x

### Requirements

```
terraform {
  required_version = ">=0.13"
  required_providers {
    scalr = {
      source  = "registry.scalr.io/scalr/scalr"
      version = "1.0.0-rc28"

    }
  }
}

provider "scalr" {
  hostname = SCALR HOSTNAME
  token    = SCALR TOKEN
}
```

### Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment_id | Environment which workspace will be created in. | `string` | n/a | Yes |
| name | Workspace name. | `string` | n/a | Yes |
| auto_apply | Auto apply on successful plan. | `bool` | `false` | No |
| operations | Set to configure workspace remote execution in CLI-driven mode. | `bool` | `true` | No |
| terraform_version | Terraform version for workspace | `string` | `0.13.0` | No |
| working_directory | A relative path that Terraform will be run in. | `string` | `null` | No |
| run_operation_timeout | The number of minutes run operation can be executed before termination. | `integer` | `0` | No |
| agent_pool_id | The identifier of an agent pool. | `string` | `null` | No |
| vcs_provider_id | ID of vcs provider | `string` | `null` | No |
| vcs_repo | VCS repo configuration | `list(object({identifier = string, branch = string, path = string, trigger_prefixes = object, dry_runs_enabled = bool}))` | `[]` | No |
| hooks | Hooks configuration | ``list(object({pre_plan = string, post_plan = string, pre_apply = string, post_apply = string}))`` | `[]` | No |


### Examples
#### Single Workspace
```
# VCS Workspace
module "single-workspace-vcs" {
  source = "./terraform-scalr-workspace"

  name     = "single-workspace-vcs"
  environment_id = "env-123"

  # VCS setting
  working_directory = "some-dir/"
  vcs_provider_id   = "vcs-123"
  vcs_repo = [
    {
      identifier       = "SomeOrganization/somerepo",
      branch           = "main",
      path             = "some-path/",
      trigger_prefixes = ["some-prefix"],
      dry_runs_enabled = true
    }
  ]
}
```
#### Multiple Workspaces
```
# Multiple workspaces
variable workspaces {
  default = {
    "workspace-multi-1" = {
      name = "workspace-multi-1",
      environment_id= "env-123",
      working_directory = "some-dir/",
      vcs_provider_id   = "vcs-123",
      vcs_repo = [{
          identifier       = "SomeOrganization/somerepo",
          branch           = "main",
          path             = "some-path/",
          trigger_prefixes = ["some-prefix"],
          dry_runs_enabled = true
        }]
     },
    "workspace-multi-2" = {
      name = "workspace-multi-2",
      environment_id= "env-123",
      working_directory = "some-dir/",
      vcs_provider_id   = "vcs-123",
      vcs_repo = [{
          identifier       = "SomeOrganization/somerepo",
          branch           = "main",
          path             = "some-path/",
          trigger_prefixes = ["some-prefix"],
          dry_runs_enabled = true
        }]
    }
  }
}

module "multi-workspace" {

 for_each = var.workspaces
  source = "./terraform-scalr-workspace"

  name = each.value.name
  environment_id = each.value.environment_id
  working_directory = each.value.working_directory

  vcs_provider_id   = each.value.vcs_provider_id
  vcs_repo = [
    {
      identifier       = each.value.vcs_repo[0].identifier,
      branch           = each.value.vcs_repo[0].branch,
      path             = each.value.vcs_repo[0].path,
      trigger_prefixes = each.value.vcs_repo[0].trigger_prefixes,
      dry_runs_enabled = each.value.vcs_repo[0].dry_runs_enabled
    }
  ]
}
```
