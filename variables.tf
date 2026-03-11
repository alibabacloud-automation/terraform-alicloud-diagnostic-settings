variable "event_rw" {
  description = "Event read/write type. Valid values: Read, Write, All."
  type        = string
  default     = "All"
}

variable "actiontrail_trail_name" {
  description = "The name of the ActionTrail trail."
  type        = string
  default     = "actiontrail"
}

variable "trail_region" {
  description = "The region where the trail applies. Valid values: All, cn-hangzhou, ap-southeast-1, etc. Default is All."
  type        = string
  default     = "All"
}

variable "oss_bucket_name" {
  description = "The name of the OSS bucket for storing trail logs."
  type        = string
  default     = null
}

variable "sls_write_role_arn" {
  description = "RAM role ARN for ActionTrail to write to SLS. Typically uses AliyunServiceRoleForActionTrail."
  type        = string
  default     = null
}

variable "event_selectors" {
  description = "Event selectors in JSON format. Example: jsonencode([{\"ServiceName\": \"PDS\"}])"
  type        = string
  default     = null
}

variable "oss_key_prefix" {
  description = "Key prefix in the OSS bucket."
  type        = string
  default     = null
}

variable "is_organization_trail" {
  description = "Whether to create an organization trail (multi-account)."
  type        = bool
  default     = false
}

variable "data_event_trail_region" {
  description = "Regions where the trail tracks data events."
  type        = string
  default     = null
}

variable "trail_status" {
  description = "Trail status. Valid values: Enable, Disable."
  type        = string
  default     = "Enable"
}

variable "log_project_name" {
  description = "SLS log project name."
  type        = string
}

variable "log_project_description" {
  description = "SLS log project description."
  type        = string
  default     = "Log project for diagnostic settings"
}

variable "log_project_tags" {
  description = "Tags for the SLS log project."
  type        = map(string)
  default     = {}
}

variable "log_stores" {
  description = "Configuration map for SLS log stores to create."
  type = map(object({
    shard_count           = optional(number, 2)
    auto_split            = optional(bool, true)
    max_split_shard_count = optional(number, 60)
    retention_period      = optional(number, 30)
    append_meta           = optional(bool, true)
    enable_web_tracking   = optional(bool, false)
    mode                  = optional(string, "standard")
    telemetry_type        = optional(string)
  }))
  default = {}
}

variable "enable_history_delivery_job" {
  description = "Whether to enable ActionTrail history delivery job."
  type        = bool
  default     = false
}
