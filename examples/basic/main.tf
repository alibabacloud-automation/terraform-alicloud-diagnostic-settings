
data "alicloud_ram_roles" "default" {
  name_regex = "AliyunServiceRoleForActionTrail"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

module "diagnostic_settings" {
  source = "../../"

  actiontrail_trail_name = "basic-actiontrail-${random_integer.default.result}"
  trail_region           = "All"
  event_rw               = "All"

  # Module will auto-construct SLS project ARN from the created log project
  sls_write_role_arn = data.alicloud_ram_roles.default.roles[0].arn

  log_project_name = "basic-diag-project-${random_integer.default.result}"

  log_stores = {
    "application-logs" = {
      shard_count           = 2
      auto_split            = true
      max_split_shard_count = 60
      retention_period      = 90
      append_meta           = true
    }
  }
}
