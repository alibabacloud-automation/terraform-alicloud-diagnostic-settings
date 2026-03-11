
data "alicloud_ram_roles" "default" {
  name_regex = "AliyunServiceRoleForActionTrail"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

module "diagnostic_settings_advanced" {
  source = "../../"

  actiontrail_trail_name      = "adv-actiontrail-${random_integer.default.result}"
  trail_region                = "All"
  trail_status                = "Enable"
  event_rw                    = "All"
  enable_history_delivery_job = true

  # Module will auto-construct SLS project ARN from the created log project
  sls_write_role_arn = data.alicloud_ram_roles.default.roles[0].arn

  log_project_name        = "adv-diag-project-${random_integer.default.result}"
  log_project_description = "Advanced diagnostic settings project"
  log_project_tags = {
    Environment = "Production"
    Team        = "DevOps"
    Project     = "Monitoring"
  }

  log_stores = {
    "audit-logs" = {
      shard_count           = 3
      auto_split            = true
      max_split_shard_count = 60
      retention_period      = 365
      append_meta           = true
      mode                  = "standard"
    },
    "metrics-logs" = {
      shard_count           = 2
      auto_split            = false
      max_split_shard_count = 0
      retention_period      = 30
      append_meta           = true
      mode                  = "query"
    },
    "application-logs" = {
      shard_count           = 4
      auto_split            = true
      max_split_shard_count = 120
      retention_period      = 90
      append_meta           = true
      enable_web_tracking   = false
    }
  }
}
