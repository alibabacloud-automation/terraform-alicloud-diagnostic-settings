# Data sources to get current region and account information
data "alicloud_regions" "current" {
  current = true
}

data "alicloud_account" "current" {}

# Construct SLS project ARN automatically from created log project
locals {
  sls_project_arn = "acs:log:${data.alicloud_regions.current.regions[0].id}:${data.alicloud_account.current.id}:project/${alicloud_log_project.main.project_name}"
}

resource "alicloud_actiontrail_trail" "main" {
  trail_name              = var.actiontrail_trail_name
  trail_region            = var.trail_region
  event_rw                = var.event_rw
  oss_bucket_name         = var.oss_bucket_name
  oss_key_prefix          = var.oss_key_prefix
  sls_project_arn         = local.sls_project_arn
  sls_write_role_arn      = var.sls_write_role_arn
  is_organization_trail   = var.is_organization_trail
  data_event_trail_region = var.data_event_trail_region
  event_selectors         = var.event_selectors
  status                  = var.trail_status
}

resource "alicloud_log_project" "main" {
  project_name = var.log_project_name
  description  = var.log_project_description
  tags         = var.log_project_tags
}

resource "alicloud_log_store" "main" {
  for_each = var.log_stores

  project_name          = alicloud_log_project.main.project_name
  logstore_name         = each.key
  shard_count           = each.value.shard_count
  auto_split            = each.value.auto_split
  max_split_shard_count = each.value.max_split_shard_count
  retention_period      = each.value.retention_period
  append_meta           = each.value.append_meta
  enable_web_tracking   = each.value.enable_web_tracking
  mode                  = each.value.mode
  telemetry_type        = each.value.telemetry_type
}

resource "alicloud_actiontrail_history_delivery_job" "main" {
  count = var.enable_history_delivery_job ? 1 : 0

  trail_name = alicloud_actiontrail_trail.main.id
}
