resource "google_pubsub_topic" "payoffs-mail-pubsub" {
  provider = google-beta
  name = var.pubsub-budget-topic
}
