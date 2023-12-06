resource "azurerm_mssql_virtual_machine" "vm" {
  virtual_machine_id = var.virtual_machine_id

  sql_license_type                 = var.sql_license_type
  r_services_enabled               = var.r_services_enabled
  sql_connectivity_port            = var.sql_connectivity_port
  sql_connectivity_type            = var.sql_connectivity_type
  sql_connectivity_update_username = var.sql_connectivity_update_username
  sql_connectivity_update_password = var.sql_connectivity_update_password
  sql_virtual_machine_group_id     = var.sql_virtual_machine_group_id
  tags                             = merge(local.module_tags, var.tags)

  dynamic "auto_backup" {
    for_each = var.auto_backup == null ? [] : [var.auto_backup]
    content {
      encryption_enabled              = auto_backup.value.encryption_password != null ? true : false
      encryption_password             = auto_backup.value.encryption_password
      retention_period_in_days        = auto_backup.value.retention_period_in_days
      storage_account_access_key      = auto_backup.value.storage_account_access_key
      storage_blob_endpoint           = auto_backup.value.storage_blob_endpoint
      system_databases_backup_enabled = auto_backup.value.system_databases_backup_enabled

      dynamic "manual_schedule" {
        for_each = auto_backup.value.manual_schedule == null ? [] : [auto_backup.value.manual_schedule]
        content {
          days_of_week                    = manual_schedule.value.days_of_week
          full_backup_frequency           = manual_schedule.value.full_backup_frequency
          full_backup_start_hour          = manual_schedule.value.full_backup_start_hour
          full_backup_window_in_hours     = manual_schedule.value.full_backup_window_in_hours
          log_backup_frequency_in_minutes = manual_schedule.value.log_backup_frequency_in_minutes
        }
      }
    }
  }

  dynamic "auto_patching" {
    for_each = var.auto_patching == null ? [] : [var.auto_patching]
    content {
      day_of_week                            = auto_patching.value.day_of_week
      maintenance_window_duration_in_minutes = auto_patching.value.maintenance_window_duration_in_minutes
      maintenance_window_starting_hour       = auto_patching.value.maintenance_window_starting_hour
    }
  }

  dynamic "key_vault_credential" {
    for_each = var.key_vault_credential == null ? [] : [var.key_vault_credential]
    content {
      name                     = key_vault_credential.value.name
      key_vault_url            = key_vault_credential.value.key_vault_url
      service_principal_name   = key_vault_credential.value.service_principal_name
      service_principal_secret = key_vault_credential.value.service_principal_secret
    }
  }

  dynamic "sql_instance" {
    for_each = var.sql_instance == null ? [] : [var.sql_instance]
    content {
      adhoc_workloads_optimization_enabled = sql_instance.value.adhoc_workloads_optimization_enabled
      collation                            = sql_instance.value.collation
      instant_file_initialization_enabled  = sql_instance.value.instant_file_initialization_enabled
      lock_pages_in_memory_enabled         = sql_instance.value.lock_pages_in_memory_enabled
      max_dop                              = sql_instance.value.max_dop
      max_server_memory_mb                 = sql_instance.value.max_server_memory_mb
      min_server_memory_mb                 = sql_instance.value.min_server_memory_mb
    }
  }

  dynamic "storage_configuration" {
    for_each = var.storage_configuration == null ? [] : [var.storage_configuration]
    content {
      disk_type                      = storage_configuration.value.disk_type
      storage_workload_type          = storage_configuration.value.storage_workload_type
      system_db_on_data_disk_enabled = storage_configuration.value.system_db_on_data_disk_enabled

      dynamic "data_settings" {
        for_each = storage_configuration.value.data_settings == null ? [] : [storage_configuration.value.data_settings]
        content {
          default_file_path = data_settings.value.default_file_path
          luns              = data_settings.value.luns
        }
      }

      dynamic "log_settings" {
        for_each = storage_configuration.value.log_settings == null ? [] : [storage_configuration.value.log_settings]
        content {
          default_file_path = log_settings.value.default_file_path
          luns              = log_settings.value.luns
        }
      }

      dynamic "temp_db_settings" {
        for_each = storage_configuration.value.temp_db_settings == null ? [] : [storage_configuration.value.temp_db_settings]
        content {
          default_file_path      = temp_db_settings.value.default_file_path
          luns                   = temp_db_settings.value.luns
          data_file_count        = temp_db_settings.value.data_file_count
          data_file_growth_in_mb = temp_db_settings.value.data_file_growth_in_mb
          data_file_size_mb      = temp_db_settings.value.data_file_size_mb
          log_file_growth_mb     = temp_db_settings.value.log_file_growth_mb
          log_file_size_mb       = temp_db_settings.value.log_file_size_mb
        }
      }
    }
  }

  dynamic "assessment" {
    for_each = var.assessment == null ? [] : [var.assessment]
    content {
      enabled         = assessment.value.enabled
      run_immediately = assessment.value.run_immediately

      dynamic "schedule" {
        for_each = assessment.value.schedule == null ? [] : [assessment.value.schedule]
        content {
          weekly_interval    = schedule.value.weekly_interval
          monthly_occurrence = schedule.value.monthly_occurrence
          day_of_week        = schedule.value.day_of_week
          start_time         = schedule.value.start_time
        }
      }
    }
  }

  dynamic "wsfc_domain_credential" {
    for_each = var.wsfc_domain_credential == null ? [] : [var.wsfc_domain_credential]
    content {
      cluster_bootstrap_account_password = wsfc_domain_credential.value.cluster_bootstrap_account_password
      cluster_operator_account_password  = wsfc_domain_credential.value.cluster_operator_account_password
      sql_service_account_password       = wsfc_domain_credential.value.sql_service_account_password
    }
  }
}
