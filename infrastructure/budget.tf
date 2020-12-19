data "google_billing_account" "account" {
  provider  = google-beta
  billing_account = var.billing-account
}

resource "google_billing_budget" "budget" {
  provider = google-beta
  billing_account = data.google_billing_account.account.id
  display_name = "Budget Keeper Budget"

  budget_filter {
    credit_types_treatment = "EXCLUDE_ALL_CREDITS"
  }

  amount {
    specified_amount {
      currency_code = var.budget-currency
      units = var.budget-amount
    }
  }

  threshold_rules {
    threshold_percent = 0.5
  }
  threshold_rules {
    threshold_percent = 0.8
  }
  threshold_rules {
    threshold_percent = 1
  }

  all_updates_rule {
    pubsub_topic = "projects/${var.gcp-project}/topics/${var.pubsub-budget-topic}"
  }

}
