# advanced

This example demonstrates the advanced usage of the Alibaba Cloud Diagnostic Settings module with multiple log stores and organization-level tracking.

## Usage

To run this example, execute the following commands:

```bash
terraform init
terraform plan
terraform apply
```

Make sure to configure your Alibaba Cloud credentials before running the example.

To destroy the resources created by this example:

```bash
terraform destroy
```

This advanced example includes:
- Organization-level ActionTrail tracking
- Multiple SLS log stores with different configurations
- Custom tags for resource identification
- Extended retention periods for audit logs

**Note:** Running this example may incur costs. Please review the ActionTrail pricing and SLS pricing before deploying.