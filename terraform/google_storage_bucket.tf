# necessary for running fine-tuning jobs
resource "google_storage_bucket_iam_binding" "vertex_ai" {
  for_each = toset([
    "roles/storage.objectAdmin",
  ])

  bucket = google_storage_bucket.vertex_ai.name
  role   = each.key
  members = [
    "serviceAccount:${module.vertex_ai_sa.email}",
  ]
}

resource "random_id" "bucket_postfix" {
  byte_length = 8
}

resource "google_storage_bucket" "vertex_ai" {
  name     = var.storage_bucket_name != "" ? var.storage_bucket_name : "${var.gcp_project_id}-${random_id.bucket_postfix.hex}"
  location = "US"

  autoclass {
    enabled = true
  }

  labels = {
    content = "vertex-ai-models"
  }
}
