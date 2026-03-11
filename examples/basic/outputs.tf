output "actiontrail_trail" {
  description = "The created ActionTrail trail resource."
  value       = module.diagnostic_settings.actiontrail_trail
}

output "log_project" {
  description = "The created SLS log project resource."
  value       = module.diagnostic_settings.log_project
}

output "log_stores" {
  description = "The created SLS log store resources."
  value       = module.diagnostic_settings.log_stores
}
