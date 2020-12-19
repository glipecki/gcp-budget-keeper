terraform {
  backend "gcs" {
    bucket = "budget-keeper-infrastructure"
    prefix = "terraform/state"
  }
}
