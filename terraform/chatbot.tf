module "chatbot" {
  source = "./cloud_run/chatbot"
  count  = var.chatbot_service_image == "" ? 0 : 1

  gcp_project_id = var.gcp_project_id
  location       = var.gcp_region

  name  = "chatbot"
  image = var.chatbot_service_image

  max_instance_request_concurrency = 80

  resources_limits_cpu    = "1000m"
  resources_limits_memory = "1000Mi"

  scaling_max_instance_count = 1
  scaling_min_instance_count = 1


  depends_on = [
    google_project_service.services["run.googleapis.com"],
  ]
}
