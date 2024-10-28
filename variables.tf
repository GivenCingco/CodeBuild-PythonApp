variable "account_id" {
  description = "AWS account ID"
  type        = string
  default     = "009160050878"
}

variable "codestart_connector_cred" {
  type        = string
  default     = "arn:aws:codeconnections:us-east-1:009160050878:connection/e45787a2-fc5d-453f-a71f-58608f57d13b"
  description = "Variable for CodeStar connection credentials"

}

variable "image_repo_name" {
  description = "Image repo name"
  type        = string
  default     = "python-docker-app"
}

variable "image_tag" {
  description = "Image tag"
  type        = string
  default     = "latest"
}


variable "region" {
  description = "Reigon"
  type        = string
  default     = "us-east-1"
}

variable "bucket" {
  description = "Bucket "
  type        = string
  default     = "given-cingco-devops-directive-tf-state"
}

variable "github_url" {
  description = "source of the buildpec file on GitHub "
  type        = string
  default     = "https://github.com/GivenCingco/python-demo-app"
}