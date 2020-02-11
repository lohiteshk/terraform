
variable "instance_name" {
  type    = "string"
  default = "terraform-vm-venkat"
}

variable "machine_type" {
  type    = "string"
  default = "n1-standard-1"
}

variable "image" {
  type    = "string"
  default = "centos-cloud/centos-6"
}

variable "VPC_name" {
  type    = "string"
  default = "myvpctest-2"
}
