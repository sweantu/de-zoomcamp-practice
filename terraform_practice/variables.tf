variable "credentials" {
  description = "The path to the GCP credentials file"
  default = "~/.gcp/develop@airbnb-dez-project.json"
}

variable "project" {
  description = "The project ID to deploy resources to"
  default = "airbnb-dez-project"
}

variable "region" {
  description = "The region to deploy resources to"
  default = "us-central1"
}

variable "bucket_name" {
  description = "The name of the bucket to deploy resources to"
  default = "airbnb-dez-project-bucket"
}

variable "location" {
  description = "The location of the bucket to deploy resources to"
  default = "us"
}


variable "dataset_id" {
  description = "The ID of the dataset to deploy resources to"
  default = "airbnb_dez_project_dataset"
}


