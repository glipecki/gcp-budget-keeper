resource "google_project_service" "gcp_services" {
  provider = google-beta
  count   = length(var.gcp_service_list)
  project = var.gcp-project
  service = var.gcp_service_list[count.index]

  disable_dependent_services = true
}
