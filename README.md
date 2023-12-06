<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.80.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.80.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_mssql_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assessment"></a> [assessment](#input\_assessment) | n/a | <pre>object({<br>    enabled         = optional(bool, true)<br>    run_immediately = optional(bool, false)<br>    schedule = optional(object({<br>      day_of_week        = string<br>      start_time         = string<br>      weekly_interval    = optional(number)<br>      monthly_occurrence = optional(number)<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_auto_backup"></a> [auto\_backup](#input\_auto\_backup) | n/a | <pre>object({<br>    encryption_password             = optional(string)<br>    retention_period_in_days        = number<br>    storage_account_access_key      = string<br>    storage_blob_endpoint           = string<br>    system_databases_backup_enabled = optional(bool, false)<br>    manual_schedule = optional(object({<br>      days_of_week                    = optional(list(string))<br>      full_backup_frequency           = string<br>      full_backup_start_hour          = number<br>      full_backup_window_in_hours     = number<br>      log_backup_frequency_in_minutes = number<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_auto_patching"></a> [auto\_patching](#input\_auto\_patching) | n/a | <pre>object({<br>    day_of_week                            = string<br>    maintenance_window_duration_in_minutes = number<br>    maintenance_window_starting_hour       = number<br>  })</pre> | `null` | no |
| <a name="input_enable_module_tags"></a> [enable\_module\_tags](#input\_enable\_module\_tags) | (Optional) Enable or not built-in mapping of tags which should be assigned to the Virtual Network. Default to 'true'. | `bool` | `true` | no |
| <a name="input_key_vault_credential"></a> [key\_vault\_credential](#input\_key\_vault\_credential) | n/a | <pre>object({<br>    name                     = string<br>    key_vault_url            = string<br>    service_principal_name   = string<br>    service_principal_secret = string<br>  })</pre> | `null` | no |
| <a name="input_r_services_enabled"></a> [r\_services\_enabled](#input\_r\_services\_enabled) | (Optional) Should R Services be enabled? | `bool` | `false` | no |
| <a name="input_sql_connectivity_port"></a> [sql\_connectivity\_port](#input\_sql\_connectivity\_port) | (Optional) The SQL Server port. Defaults to 1433. | `number` | `1433` | no |
| <a name="input_sql_connectivity_type"></a> [sql\_connectivity\_type](#input\_sql\_connectivity\_type) | (Optional) The connectivity type used for this SQL Server. Possible values are LOCAL, PRIVATE and PUBLIC. Defaults to PRIVATE. | `string` | `"PRIVATE"` | no |
| <a name="input_sql_connectivity_update_password"></a> [sql\_connectivity\_update\_password](#input\_sql\_connectivity\_update\_password) | (Optional) The SQL Server sysadmin login password. | `string` | `null` | no |
| <a name="input_sql_connectivity_update_username"></a> [sql\_connectivity\_update\_username](#input\_sql\_connectivity\_update\_username) | (Optional) The SQL Server sysadmin login to create. | `string` | `null` | no |
| <a name="input_sql_instance"></a> [sql\_instance](#input\_sql\_instance) | n/a | <pre>object({<br>    adhoc_workloads_optimization_enabled = optional(bool, false)<br>    collation                            = optional(string, "SQL_Latin1_General_CP1_CI_AS")<br>    instant_file_initialization_enabled  = optional(bool, false)<br>    lock_pages_in_memory_enabled         = optional(bool, false)<br>    max_dop                              = optional(number, 0)<br>    max_server_memory_mb                 = optional(number, 2147483647)<br>    min_server_memory_mb                 = optional(number, 0)<br>  })</pre> | `null` | no |
| <a name="input_sql_license_type"></a> [sql\_license\_type](#input\_sql\_license\_type) | (Optional) The SQL Server license type. Possible values are AHUB (Azure Hybrid Benefit), DR (Disaster Recovery), and PAYG (Pay-As-You-Go). Changing this forces a new resource to be created. | `string` | `"PAYG"` | no |
| <a name="input_sql_virtual_machine_group_id"></a> [sql\_virtual\_machine\_group\_id](#input\_sql\_virtual\_machine\_group\_id) | (Optional) The ID of the SQL Virtual Machine Group that the SQL Virtual Machine belongs to. | `string` | `null` | no |
| <a name="input_storage_configuration"></a> [storage\_configuration](#input\_storage\_configuration) | n/a | <pre>object({<br>    disk_type                      = string<br>    storage_workload_type          = string<br>    system_db_on_data_disk_enabled = optional(bool, false)<br>    data_settings = optional(object({<br>      default_file_path = string<br>      luns              = list(number)<br>    }))<br>    log_settings = optional(object({<br>      default_file_path = string<br>      luns              = list(number)<br>    }))<br>    temp_db_settings = optional(object({<br>      default_file_path      = string<br>      luns                   = list(number)<br>      data_file_count        = optional(number, 8)<br>      data_file_size_mb      = optional(number, 256)<br>      data_file_growth_in_mb = optional(number, 512)<br>      log_file_size_mb       = optional(number, 256)<br>      log_file_growth_mb     = optional(number, 512)<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags which should be assigned to the Virtual Network. | `map(string)` | `{}` | no |
| <a name="input_virtual_machine_id"></a> [virtual\_machine\_id](#input\_virtual\_machine\_id) | (Required) The ID of the Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_wsfc_domain_credential"></a> [wsfc\_domain\_credential](#input\_wsfc\_domain\_credential) | n/a | <pre>object({<br>    cluster_bootstrap_account_password = string<br>    cluster_operator_account_password  = string<br>    sql_service_account_password       = string<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the SQL Virtual Machine. |
<!-- END_TF_DOCS -->