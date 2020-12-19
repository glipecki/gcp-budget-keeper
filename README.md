# gcp-budget-keeper

use or create project for billing tools
  - make sure cloudresourcemanager.googleapis.com api is enabled

use service account for authentication: https://cloud.google.com/sdk/docs/authorizing
  - make sure service account has permissions for: ???

create terraform bucket for state storage
  - gsutil mb -p {project-id} gs://{terraform-bucket}

create env tfvars based on env.tfvars.template
run make with params 
  - make credentials=service-account-json env=env-tfvars-file
