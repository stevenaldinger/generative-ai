variable "gcp_project_id" {
  description = "The GCP Project ID to create resources in."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region to create resources in."
  type        = string
  default     = "us-central1"
}

variable "storage_bucket_name" {
  description = "The name of the storage bucket to create."
  type        = string
  default     = ""
}

variable "user_email_address" {
  description = "The email address of the user to grant access to the service account."
  type        = string
  default     = ""
}

variable "chatbot_service_image" {
  description = "If a docker image is set, the chatbot will be deployed."
  type        = string
  default     = ""
}
