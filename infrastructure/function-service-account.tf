resource "google_service_account" "function-service-account" {
  provider = google-beta
  depends_on = [google_project_service.gcp_services]

  account_id   = "budget-keeper-service-account"
  display_name = "GCP Budget Keeper service account"
  description = "Service account used to manage project billings (disables billing on threshold)"
}

resource "google_billing_account_iam_member" "function-service-account-admin" {
  provider = google-beta
  depends_on = [google_project_service.gcp_services]

  billing_account_id = var.billing-account
  role               = "roles/billing.admin"
  member             = "serviceAccount:${google_service_account.function-service-account.email}"
}
