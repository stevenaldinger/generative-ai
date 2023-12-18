module "chatbot_service_account" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "4.2.2"

  display_name = var.name
  description  = "${var.name} application's service account."
  names        = [var.name]

  project_id    = var.gcp_project_id
  project_roles = ["${var.gcp_project_id}=>roles/aiplatform.user"]
}
