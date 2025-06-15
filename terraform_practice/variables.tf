variable "credentials" {
  description = "The path to the GCP credentials file"
  default = "~/.gcp/terraform-practice.json"
}

variable "project" {
  description = "The project ID to deploy resources to"
  default = "de-zoomcamp-practice-451708"
}

variable "region" {
  description = "The region to deploy resources to"
  default = "asia-southeast1-b"
}

variable "bucket_name" {
  description = "The name of the bucket to deploy resources to"
  default = "de-zoomcamp-practice-451708-terraform-bucket"
}

variable "location" {
  description = "The location of the bucket to deploy resources to"
  default = "asia"
}


variable "dataset_id" {
  description = "The ID of the dataset to deploy resources to"
  default = "terraform_dataset"
}


