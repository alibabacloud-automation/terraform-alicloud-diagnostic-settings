阿里云诊断设置 Terraform 模块

# terraform-alicloud-diagnostic-settings

[English](https://github.com/alibabacloud-automation/terraform-alicloud-diagnostic-settings/blob/main/README.md) | 简体中文

本 Terraform 模块在阿里云上提供诊断日志和监控功能，类似于 [Azure Diagnostic Settings](https://github.com/claranet/terraform-azurerm-diagnostic-settings)。它利用 [操作审计（ActionTrail）](https://help.aliyun.com/zh/actiontrail/) 进行 API 审计日志记录，使用 [日志服务（SLS）](https://help.aliyun.com/zh/sls/) 进行全面的日志收集和分析。

## 使用方法

创建 ActionTrail 跟踪以及 SLS 日志项目和日志库，实现集中式诊断日志记录。

```terraform
module "diagnostic_settings" {
  source = "alibabacloud-automation/diagnostic-settings/alicloud"

  enable_actiontrail     = true
  actiontrail_trail_name = "my-actiontrail"
  event_rw               = "All"

  logs_destinations_ids = {
    oss_bucket  = "my-log-bucket"
    sls_project = "acs:log:cn-hangzhou:123456789:project/my-project"
    sls_role    = "acs:ram::123456789:role/aliyunlogdefaultrole"
  }

  create_log_project = true
  log_project_name   = "my-diag-project"

  log_stores = {
    "application-logs" = {
      retention_period = 90
    }
  }
}
```

## 示例

* [基础示例](https://github.com/alibabacloud-automation/terraform-alicloud-diagnostic-settings/tree/main/examples/basic)
* [高级示例](https://github.com/alibabacloud-automation/terraform-alicloud-diagnostic-settings/tree/main/examples/advanced)

<!-- BEGIN_TF_DOCS -->
Copyright 2026 Alibaba Group Holding Limited.
SPDX-License-Identifier: Apache-2.0

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.200.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | 1.272.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_actiontrail_trail.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/actiontrail_trail) | resource |
| [alicloud_log_project.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_project) | resource |
| [alicloud_log_store.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_store) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_log_project"></a> [create\_log\_project](#input\_create\_log\_project) | Whether to create a new SLS log project. | `bool` | `true` | no |
| <a name="input_actiontrail_trail_name"></a> [actiontrail\_trail\_name](#input\_actiontrail\_trail\_name) | The name of the ActionTrail trail. | `string` | `"actiontrail"` | no |
| <a name="input_data_event_trail_region"></a> [data\_event\_trail\_region](#input\_data\_event\_trail\_region) | Regions where the trail tracks data events. | `string` | `null` | no |
| <a name="input_enable_actiontrail"></a> [enable\_actiontrail](#input\_enable\_actiontrail) | Whether to enable ActionTrail tracking. | `bool` | `true` | no |
| <a name="input_event_rw"></a> [event\_rw](#input\_event\_rw) | Event read/write type. Valid values: Read, Write, All. | `string` | `"All"` | no |
| <a name="input_is_organization_trail"></a> [is\_organization\_trail](#input\_is\_organization\_trail) | Whether to create an organization trail (multi-account). | `bool` | `false` | no |
| <a name="input_log_project_description"></a> [log\_project\_description](#input\_log\_project\_description) | SLS log project description. | `string` | `"Log project for diagnostic settings"` | no |
| <a name="input_log_project_name"></a> [log\_project\_name](#input\_log\_project\_name) | SLS log project name. | `string` | `null` | no |
| <a name="input_log_project_tags"></a> [log\_project\_tags](#input\_log\_project\_tags) | Tags for the SLS log project. | `map(string)` | `{}` | no |
| <a name="input_log_stores"></a> [log\_stores](#input\_log\_stores) | Configuration map for SLS log stores to create. | <pre>map(object({<br/>    shard_count           = optional(number, 2)<br/>    auto_split            = optional(bool, true)<br/>    max_split_shard_count = optional(number, 60)<br/>    retention_period      = optional(number, 30)<br/>    append_meta           = optional(bool, true)<br/>    enable_web_tracking   = optional(bool, false)<br/>    mode                  = optional(string, "standard")<br/>    telemetry_type        = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_logs_destinations_ids"></a> [logs\_destinations\_ids](#input\_logs\_destinations\_ids) | Log destination IDs mapping for OSS bucket, SLS project and role ARNs. | <pre>object({<br/>    oss_bucket  = optional(string)<br/>    sls_project = optional(string)<br/>    sls_role    = optional(string)<br/>  })</pre> | `{}` | no |

| <a name="input_oss_key_prefix"></a> [oss\_key\_prefix](#input\_oss\_key\_prefix) | Key prefix in the OSS bucket. | `string` | `null` | no |
| <a name="input_trail_status"></a> [trail\_status](#input\_trail\_status) | Trail status. Valid values: Enable, Disable. | `string` | `"Enable"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_actiontrail_trails"></a> [actiontrail\_trails](#output\_actiontrail\_trails) | The created ActionTrail trail resources. |
| <a name="output_combined_diagnostic_settings"></a> [combined\_diagnostic\_settings](#output\_combined\_diagnostic\_settings) | Combined diagnostic settings summary information. |
| <a name="output_log_projects"></a> [log\_projects](#output\_log\_projects) | The created SLS log project resources. |
| <a name="output_log_stores"></a> [log\_stores](#output\_log\_stores) | The created SLS log store resources. |
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
