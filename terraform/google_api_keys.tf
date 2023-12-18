resource "google_apikeys_key" "custom_search" {
  name         = "custom-search-engine"
  display_name = "Custom Search Engine"
  project      = var.gcp_project_id

  restrictions {
    api_targets {
      service = google_project_service.services["customsearch.googleapis.com"].service
      methods = ["google.customsearch.v1.CustomSearchService.List"]
    }
  }

  depends_on = [
    google_project_service.services["apikeys.googleapis.com"],
  ]
}
