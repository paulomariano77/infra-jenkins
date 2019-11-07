variable "resource_group" {
    default = ""
}

variable "location" {
    default = "eastus2"
}

variable "tags" {
    type = "map"

    default = {}
}
