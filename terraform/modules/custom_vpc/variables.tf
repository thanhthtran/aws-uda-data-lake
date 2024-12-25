variable "project" {
  description = "Project name"
  type        = string
}

variable "region" {
  description = "Region name"
  type        = string
}
variable "zone1" {
  description = "zone name 1"

}
variable "zone2" {
  description = "zone name 2"

}
variable "cidr_all" {
  description = "The CIDR block allowed to access"
  type        = string
}
variable "cidr_main_vpc" {
  description = "The CIDR block for the VPC"
  type        = string
}
variable "cidr_pub1" {
  description = "The CIDR block for pub1 subnet"
  type        = string
}

variable "cidr_pub2" {
  description = "The CIDR block for pub2 subnet"
  type        = string
}


variable "cidr_private1" {
  description = "The CIDR block for private 1 subnet"
  type        = string
}
variable "cidr_private2" {
  description = "The CIDR block for private 1 subnet"
  type        = string
}
