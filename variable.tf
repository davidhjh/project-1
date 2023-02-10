variable "users" {
  default = ["afsah, jaspal, matthew, jaldeep"]
}

variable "s3_bucket_name" {
  default = "project-bucket-names"
}

variable "resource_group_name" {
    default = "project-resource-group"
}

variable "virtual_machine_name" {
    default = "project-virtual-machine"
}

variable "storage_account_name" {
    default = "project-storage-account"
}

variable "virtual_network_name" {
    default = "primary-network"
}

variable "subnet_name" {
    default = "internal"
}

variable "nic_name" {
    default = "primary-nic"
}

