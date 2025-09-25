variable "project_id" {
  type = string
}

variable "zone" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "name" {
  type = string
}

variable "public_ip" {
  type    = bool
  default = false
}
