# not used here, but is useful if you put a load balancer in front of the service
output "region_network_endpoint_group_id" {
  value = google_compute_region_network_endpoint_group.chatbot.id
}

output "uri" {
  value = google_cloud_run_v2_service.chatbot.uri
}
