# Terraform

This directory contains the Terraform configuration for the project. It's used to set up the Google Cloud project and resources needed to run the examples.

**NOTE:** the environment variables are configured automatically if you followed the [Google Project Setup](../docs/google-project-setup/README.md) instructions (the `make` commands for local config setup).

The following environment variables are configured in the [docker-compose.yml](./docker-compose.yml) file:
- `GCP_PROJECT` environment variable gets mapped to `TF_VAR_gcp_project_id` - the Google Cloud project id to configure and create resources in
- `GCP_REGION` environment variable gets mapped to `TF_VAR_gcp_region` - the Google Cloud region to create resources in
- `CHATBOT_SERVICE_IMAGE` environment variable gets mapped to `TF_VAR_chatbot_service_image` - the Docker image to use for the chatbot service. if this is an empty string (default), the chatbot service will not be deployed.
- `USER_EMAIL_ADDRESS` environment variable gets mapped to `TF_VAR_user_email_address` - the email address to give `roles/iam.serviceAccountUser` access to for the user account that will be created
