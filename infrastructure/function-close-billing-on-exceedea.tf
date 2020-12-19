data "archive_file" "close-billing-on-exceeded-quota" {
  type = "zip"
  source_dir = "../function-close-billing-on-exceeded-quota"
  output_path = "${var.dir-build}/close-billing-on-exceeded-quota.zip"
  excludes = [
    "../function-close-billing-on-exceeded-quota/node_modules"
  ]
}

resource "google_storage_bucket_object" "close-billing-on-exceeded-quota" {
  provider = google-beta
  name = format("%s.%s.zip", "close-billing-on-exceeded-quota", data.archive_file.close-billing-on-exceeded-quota.output_md5)
  bucket = google_storage_bucket.functions-source-archive.name
  source = "${var.dir-build}/close-billing-on-exceeded-quota.zip"
}

resource "google_cloudfunctions_function" "close-billing-on-exceeded-quota" {
  provider = google-beta
  name = "close-billing-on-exceeded-quota"
  project = var.gcp-project
  region = var.gcp-region
  runtime = "nodejs12"
  available_memory_mb = 128
  entry_point = "closeBillingOnExceededQuota"
  source_archive_bucket = google_storage_bucket.functions-source-archive.name
  source_archive_object = google_storage_bucket_object.close-billing-on-exceeded-quota.name
  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource = google_pubsub_topic.payoffs-mail-pubsub.name
  }
}
