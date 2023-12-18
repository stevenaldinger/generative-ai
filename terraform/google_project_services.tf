resource "google_project_service" "services" {
  for_each = toset([
    # for vertex ai
    "aiplatform.googleapis.com",
    # for custom search engine
    "apikeys.googleapis.com",
    # for interacting with google developers console api
    "cloudresourcemanager.googleapis.com",
    # for supervised learning pipeline
    "compute.googleapis.com",
    # for deploying chatbot cloud run service
    "containerregistry.googleapis.com",
    # for custom search engine
    "customsearch.googleapis.com",
    # necessary for service account management
    "iam.googleapis.com",
    # for deploying chatbot cloud run service
    "run.googleapis.com",
  ])

  service = each.key
}
