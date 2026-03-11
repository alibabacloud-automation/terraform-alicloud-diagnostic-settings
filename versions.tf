/**
 * Copyright 2026 Alibaba Group Holding Limited.
 * SPDX-License-Identifier: Apache-2.0
 */

terraform {
  required_version = ">= 1.0"
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = ">= 1.200.0"
    }
  }
}