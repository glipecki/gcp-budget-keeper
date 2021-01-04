gcp-region = "europe-west3"
gcp-zone = "europe-west3-a"
gcp-location = "eu"
dir-build = "build"
budget-amount = "5"
budget-currency = "USD"
budget-threshold-warning = 0.5
budget-threshold-cutoff = 0.8
pubsub-budget-topic = "budget-keeper-budgets"
bucket-function-source-archives = "functions-source-archive"
gcp_service_list = [
  "cloudbilling.googleapis.com",
  "pubsub.googleapis.com",
  "cloudfunctions.googleapis.com",
  "cloudbuild.googleapis.com",
  "iam.googleapis.com",
  "billingbudgets.googleapis.com"
]
function-close-billing-on-exceeded-quota-config-json = {}
