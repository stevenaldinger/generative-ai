output "chatbot_uri" {
  value = module.chatbot[*].uri
}

output "custom_search_api_key" {
  value       = google_apikeys_key.custom_search.key_string
  description = "API key for Custom Search Engine"
  sensitive   = true
}

output "vertex_ai_sa_key" {
  value       = module.vertex_ai_sa.key
  description = "JSON service account key for Vertex AI service account"
  sensitive   = true
}

output "google_storage_bucket_name" {
  value       = google_storage_bucket.vertex_ai.name
  description = "Name of the Google Storage bucket"
}
