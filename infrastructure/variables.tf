variable "gcp-project" {}
variable "gcp-region" {}
variable "gcp-zone" {}
variable "gcp-location" {}
variable "pubsub-budget-topic" {}
variable "billing-account" {}
variable "budget-amount" {}
variable "budget-currency" {}
variable "dir-build" {}
variable "bucket-function-source-archives" {}
variable "gcp_service_list" {
  description = "List of GCP service to be enabled for a project."
  type        = list
}
variable "function-close-billing-on-exceeded-quota-config-json" {}
