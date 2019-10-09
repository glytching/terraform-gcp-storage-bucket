variable "project_id" {
  description = ""
}

variable "project_editor_key" {
  default = ""
}

variable "location" {
  default = "europe-west2"
}

variable "storage_class" {
  default = "REGIONAL"
}

variable "max_age_seconds" {
  default = "3600"
}

variable "http_methods" {
  default = ["GET", "POST"]
}

variable "response_headers" {
  default = ["foo", "bar"]
}

variable "origins" {
  default = ["*"]
}