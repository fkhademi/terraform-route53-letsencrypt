# terraform-route53-letsencrypt

### Description

This will create a Route53 hostname as well as a signed SSL certificate using LetsEncrypt

### Usage Example
```
module "record" {
  source            = "git::https://github.com/fkhademi/terraform-route53-letsencrypt.git"
  aws_access_key    = "AAA123456789"
  aws_secret_key    = "WWWABC123"
  dns_zone          = "example.tld"
  record_name       = "www"
  ip_address        = "10.10.20.20"
  email_address     = "john@example.tld"
}
```

### Variables
The following variables are required:

key | description
--- | ---
aws_access_key | AWS access key with access to Route53
aws_secret_key | AWS secret key with access to Route53
dns_zone | DNS zone hosted in Route53
record_name | DNS record name to be added to Route53 zone
ip_address | IP address for DNS record
email_address | Email used for LetsEncrypt contact


The following variables are optional:

key | default | value
--- | --- | ---
region | eu-central-1 | AWS region