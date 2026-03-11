output "actiontrail_trail" {
  description = "The created ActionTrail trail resource."
  value       = module.diagnostic_settings_advanced.actiontrail_trail
}

output "log_project" {
  description = "The created SLS log project resource."
  value       = module.diagnostic_settings_advanced.log_project
}

output "log_stores" {
  description = "The created SLS log store resources."
  value       = module.diagnostic_settings_advanced.log_stores
}

output "combined_settings" {
  description = "The combined diagnostic settings summary."
  value       = module.diagnostic_settings_advanced.combined_diagnostic_settings
}
