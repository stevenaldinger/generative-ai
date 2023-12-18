
module "vertex_ai_sa" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "4.2.2"

  project_id   = var.gcp_project_id
  names        = ["vertex-ai"]
  display_name = "vertex-ai"
  description  = "Vertex AI Service Account"

  project_roles = [
    "${var.gcp_project_id}=>roles/aiplatform.user",
    "${var.gcp_project_id}=>roles/aiplatform.serviceAgent",
  ]

  generate_keys = true

  depends_on = [
    google_project_service.services["iam.googleapis.com"],
  ]
}

resource "google_service_account_iam_member" "vertex_ai_service_account" {
  service_account_id = "projects/${var.gcp_project_id}/serviceAccounts/${module.vertex_ai_sa.email}"
  role               = "roles/iam.serviceAccountUser"
  member             = "user:${var.user_email_address}"
}
