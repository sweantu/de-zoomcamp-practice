variable "credentials" {
  description = "The path to the GCP credentials file"
  default = "~/.gcp/airbnb-de-zoomcamp-2f68e8307ebc.json"
}

variable "project" {
  description = "The project ID to deploy resources to"
  default = "airbnb-de-zoomcamp"
}

variable "region" {
  description = "The region to deploy resources to"
  default = "us-east1"
}

variable "bucket_name" {
  description = "The name of the bucket to deploy resources to"
  default = "airbnb-de-zoomcamp-bucket"
}

variable "location" {
  description = "The location of the bucket to deploy resources to"
  default = "us"
}


variable "dataset_id" {
  description = "The ID of the dataset to deploy resources to"
  default = "airbnb_de_zoomcamp_dataset"
}


