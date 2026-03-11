/**
 * Copyright 2026 Alibaba Group Holding Limited.
 * SPDX-License-Identifier: Apache-2.0
 */

output "actiontrail_trail" {
  description = "The created ActionTrail trail resource."
  value = {
    id         = alicloud_actiontrail_trail.main.id
    trail_name = alicloud_actiontrail_trail.main.trail_name
    status     = alicloud_actiontrail_trail.main.status
  }
}

output "log_project" {
  description = "The created SLS log project resource."
  value = {
    id           = alicloud_log_project.main.id
    project_name = alicloud_log_project.main.project_name
    description  = alicloud_log_project.main.description
    status       = alicloud_log_project.main.status
  }
}

output "log_stores" {
  description = "The created SLS log store resources."
  value = {
    for k, v in alicloud_log_store.main :
    k => {
      id               = v.id
      project_name     = v.project_name
      logstore_name    = v.logstore_name
      shard_count      = v.shard_count
      retention_period = v.retention_period
    }
  }
}

output "actiontrail_history_delivery_jobs" {
  description = "The created ActionTrail history delivery job resources."
  value = {
    for k, v in alicloud_actiontrail_history_delivery_job.main :
    k => {
      id         = v.id
      trail_name = v.trail_name
      status     = v.status
    }
  }
}

output "combined_diagnostic_settings" {
  description = "Combined diagnostic settings summary information."
  value = {
    history_delivery_enabled = var.enable_history_delivery_job
    log_stores               = length(alicloud_log_store.main)
    history_delivery_jobs    = length(alicloud_actiontrail_history_delivery_job.main)
    log_project_name         = alicloud_log_project.main.project_name
    actiontrail_trail_name   = alicloud_actiontrail_trail.main.trail_name
  }
}
