Alibaba Cloud Diagnostic Settings Terraform Module

# terraform-alicloud-diagnostic-settings

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-diagnostic-settings/blob/main/README-CN.md)

This Terraform module provides diagnostic logging and monitoring capabilities on Alibaba Cloud, similar to Azure Diagnostic Settings. It leverages ActionTrail for API audit logging and SLS (Simple Log Service) for comprehensive log collection and analysis.

## Usage

Create an ActionTrail trail with SLS log project and log stores for centralized diagnostic logging.

```terraform
module "diagnostic_settings" {
  source = "alibabacloud-automation/diagnostic-settings/alicloud"

  actiontrail_trail_name = "my-actiontrail"
  event_rw               = "All"
  sls_write_role_arn     = "acs:ram::123456789:role/AliyunServiceRoleForActionTrail"

  log_project_name = "my-diag-project"

  log_stores = {
    "application-logs" = {
      retention_period = 90
    }
  }
}
```

## Examples

* [Basic Example](https://github.com/alibabacloud-automation/terraform-alicloud-diagnostic-settings/tree/main/examples/basic)
* [Advanced Example](https://github.com/alibabacloud-automation/terraform-alicloud-diagnostic-settings/tree/main/examples/advanced)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.200.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.200.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_actiontrail_history_delivery_job.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/actiontrail_history_delivery_job) | resource |
| [alicloud_actiontrail_trail.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/actiontrail_trail) | resource |
| [alicloud_log_project.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_project) | resource |
| [alicloud_log_store.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_store) | resource |
| [alicloud_account.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |
| [alicloud_regions.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actiontrail_trail_name"></a> [actiontrail\_trail\_name](#input\_actiontrail\_trail\_name) | The name of the ActionTrail trail. | `string` | `"actiontrail"` | no |
| <a name="input_data_event_trail_region"></a> [data\_event\_trail\_region](#input\_data\_event\_trail\_region) | Regions where the trail tracks data events. | `string` | `null` | no |
| <a name="input_enable_history_delivery_job"></a> [enable\_history\_delivery\_job](#input\_enable\_history\_delivery\_job) | Whether to enable ActionTrail history delivery job. | `bool` | `false` | no |
| <a name="input_event_rw"></a> [event\_rw](#input\_event\_rw) | Event read/write type. Valid values: Read, Write, All. | `string` | `"All"` | no |
| <a name="input_event_selectors"></a> [event\_selectors](#input\_event\_selectors) | Event selectors in JSON format. Example: jsonencode([{"ServiceName": "PDS"}]) | `string` | `null` | no |
| <a name="input_is_organization_trail"></a> [is\_organization\_trail](#input\_is\_organization\_trail) | Whether to create an organization trail (multi-account). | `bool` | `false` | no |
| <a name="input_log_project_description"></a> [log\_project\_description](#input\_log\_project\_description) | SLS log project description. | `string` | `"Log project for diagnostic settings"` | no |
| <a name="input_log_project_name"></a> [log\_project\_name](#input\_log\_project\_name) | SLS log project name. | `string` | n/a | yes |
| <a name="input_log_project_tags"></a> [log\_project\_tags](#input\_log\_project\_tags) | Tags for the SLS log project. | `map(string)` | `{}` | no |
| <a name="input_log_stores"></a> [log\_stores](#input\_log\_stores) | Configuration map for SLS log stores to create. | <pre>map(object({<br/>    shard_count           = optional(number, 2)<br/>    auto_split            = optional(bool, true)<br/>    max_split_shard_count = optional(number, 60)<br/>    retention_period      = optional(number, 30)<br/>    append_meta           = optional(bool, true)<br/>    enable_web_tracking   = optional(bool, false)<br/>    mode                  = optional(string, "standard")<br/>    telemetry_type        = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_oss_bucket_name"></a> [oss\_bucket\_name](#input\_oss\_bucket\_name) | The name of the OSS bucket for storing trail logs. | `string` | `null` | no |
| <a name="input_oss_key_prefix"></a> [oss\_key\_prefix](#input\_oss\_key\_prefix) | Key prefix in the OSS bucket. | `string` | `null` | no |
| <a name="input_sls_write_role_arn"></a> [sls\_write\_role\_arn](#input\_sls\_write\_role\_arn) | RAM role ARN for ActionTrail to write to SLS. Typically uses AliyunServiceRoleForActionTrail. | `string` | `null` | no |
| <a name="input_trail_region"></a> [trail\_region](#input\_trail\_region) | The region where the trail applies. Valid values: All, cn-hangzhou, ap-southeast-1, etc. Default is All. | `string` | `"All"` | no |
| <a name="input_trail_status"></a> [trail\_status](#input\_trail\_status) | Trail status. Valid values: Enable, Disable. | `string` | `"Enable"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_actiontrail_history_delivery_jobs"></a> [actiontrail\_history\_delivery\_jobs](#output\_actiontrail\_history\_delivery\_jobs) | The created ActionTrail history delivery job resources. |
| <a name="output_actiontrail_trail"></a> [actiontrail\_trail](#output\_actiontrail\_trail) | The created ActionTrail trail resource. |
| <a name="output_combined_diagnostic_settings"></a> [combined\_diagnostic\_settings](#output\_combined\_diagnostic\_settings) | Combined diagnostic settings summary information. |
| <a name="output_log_project"></a> [log\_project](#output\_log\_project) | The created SLS log project resource. |
| <a name="output_log_stores"></a> [log\_stores](#output\_log\_stores) | The created SLS log store resources. |
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
