# gcp-budget-keeper

use or create project for billing tools, eg. `company-name-devops`
  - make sure cloudresourcemanager.googleapis.com api is enabled

use service account for authentication: https://cloud.google.com/sdk/docs/authorizing
  - make sure service account has permissions 
    - for tools project: owner (TODO: narrow permissions)
    - for billing account: billing administrator (TODO: narrow permissions)

use service account key file for authentication
  - activate account (with gcloud auth activate-service-account, via https://cloud.google.com/sdk/docs/authorizing)

create terraform bucket for state storage
  - gsutil mb -p {project-id} gs://${project-id}-budget-keeper-infrastructure

init terraform with `terafform init` and provide created bucket name for `Google Cloud Storage bucket`
  - GOOGLE_APPLICATION_CREDENTIALS=path/to/service-account.json terraform init \
      -backend-config="bucket=cd-devops-budget-keeper-infrastructure"

create env tfvars based on env.tfvars.template

run make with params 
  - make credentials=service-account-json env=env-tfvars-file

warning: when google apis first enabled it may take up to 10 min to propagate permissions
