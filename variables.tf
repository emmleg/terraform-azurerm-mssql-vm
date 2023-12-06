variable "virtual_machine_id" {
  description = "(Required) The ID of the Virtual Machine. Changing this forces a new resource to be created."
  type        = string
}

variable "auto_backup" {
  type = object({
    encryption_password             = optional(string)
    retention_period_in_days        = number
    storage_account_access_key      = string
    storage_blob_endpoint           = string
    system_databases_backup_enabled = optional(bool, false)
    manual_schedule = optional(object({
      days_of_week                    = optional(list(string))
      full_backup_frequency           = string
      full_backup_start_hour          = number
      full_backup_window_in_hours     = number
      log_backup_frequency_in_minutes = number
    }))
  })
  default = null
}

variable "auto_patching" {
  type = object({
    day_of_week                            = string
    maintenance_window_duration_in_minutes = number
    maintenance_window_starting_hour       = number
  })
  default = null
}

variable "key_vault_credential" {
  type = object({
    name                     = string
    key_vault_url            = string
    service_principal_name   = string
    service_principal_secret = string
  })
  default = null
}

variable "sql_instance" {
  type = object({
    adhoc_workloads_optimization_enabled = optional(bool, false)
    collation                            = optional(string, "SQL_Latin1_General_CP1_CI_AS")
    instant_file_initialization_enabled  = optional(bool, false)
    lock_pages_in_memory_enabled         = optional(bool, false)
    max_dop                              = optional(number, 0)
    max_server_memory_mb                 = optional(number, 2147483647)
    min_server_memory_mb                 = optional(number, 0)
  })
  default = null
}

variable "storage_configuration" {
  type = object({
    disk_type                      = string
    storage_workload_type          = string
    system_db_on_data_disk_enabled = optional(bool, false)
    data_settings = optional(object({
      default_file_path = string
      luns              = list(number)
    }))
    log_settings = optional(object({
      default_file_path = string
      luns              = list(number)
    }))
    temp_db_settings = optional(object({
      default_file_path      = string
      luns                   = list(number)
      data_file_count        = optional(number, 8)
      data_file_size_mb      = optional(number, 256)
      data_file_growth_in_mb = optional(number, 512)
      log_file_size_mb       = optional(number, 256)
      log_file_growth_mb     = optional(number, 512)
    }))
  })
  default = null
}

variable "assessment" {
  type = object({
    enabled         = optional(bool, true)
    run_immediately = optional(bool, false)
    schedule = optional(object({
      day_of_week        = string
      start_time         = string
      weekly_interval    = optional(number)
      monthly_occurrence = optional(number)
    }))
  })
  default = null
}

variable "wsfc_domain_credential" {
  type = object({
    cluster_bootstrap_account_password = string
    cluster_operator_account_password  = string
    sql_service_account_password       = string
  })
  default = null
}

variable "r_services_enabled" {
  description = "(Optional) Should R Services be enabled?"
  type        = bool
  default     = false
}

variable "sql_connectivity_port" {
  description = "(Optional) The SQL Server port. Defaults to 1433."
  type        = number
  default     = 1433
}

variable "sql_connectivity_type" {
  description = "(Optional) The connectivity type used for this SQL Server. Possible values are LOCAL, PRIVATE and PUBLIC. Defaults to PRIVATE."
  type        = string
  default     = "PRIVATE"
}

variable "sql_connectivity_update_username" {
  description = "(Optional) The SQL Server sysadmin login to create."
  type        = string
  default     = null
}

variable "sql_connectivity_update_password" {
  description = "(Optional) The SQL Server sysadmin login password."
  type        = string
  default     = null
  sensitive   = true
}

variable "sql_license_type" {
  description = "(Optional) The SQL Server license type. Possible values are AHUB (Azure Hybrid Benefit), DR (Disaster Recovery), and PAYG (Pay-As-You-Go). Changing this forces a new resource to be created."
  type        = string
  default     = "PAYG"
}

variable "sql_virtual_machine_group_id" {
  description = "(Optional) The ID of the SQL Virtual Machine Group that the SQL Virtual Machine belongs to."
  type        = string
  default     = null
}

variable "enable_module_tags" {
  description = "(Optional) Enable or not built-in mapping of tags which should be assigned to the Virtual Network. Default to 'true'."
  type        = bool
  default     = true
}

variable "tags" {
  description = "(Optional) A mapping of tags which should be assigned to the Virtual Network."
  type        = map(string)
  default     = {}
}
