output "dns_name" {
  value       = google_dns_managed_zone.elixir_application_app.dns_name
  description = "DNS zone name"
}