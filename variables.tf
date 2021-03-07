variable "aws_access_key" {
  description = "AWS Access Key with access to Route53 domain"
}

variable "aws_secret_key" {
  description = "AWS Secret Key with access to Route53 domain"
}

variable "aws_region" {
  description = "AWS region"
  default     = "eu-central-1"
}

variable "dns_zone" {
  description = "DNS zone in Route53"
}

variable "record_name" {
  description = "Hostname to add to Route53 and for generating SSL cert"
}

variable "ip_address" {
  description = "IP Address for Aviatrix Controller or CoPilot"
}

variable "email_address" {
  description = "Email address to add to SSL certificate"
}