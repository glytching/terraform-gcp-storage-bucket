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

variable "retention_period" {
  default = "3600"
}

variable "is_locked" {
  default = "true"
}