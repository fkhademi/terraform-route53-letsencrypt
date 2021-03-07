# Find the dns zone
data "aws_route53_zone" "obj" {
  name         = var.dns_zone
  private_zone = false
}

# Create an A record
resource "aws_route53_record" "obj" {
  zone_id = data.aws_route53_zone.obj.zone_id
  name    = "${var.record_name}.${data.aws_route53_zone.obj.name}"
  type    = "A"
  ttl     = "1"
  records = [var.ip_address]
}

## Create an SSL certificate
resource "tls_private_key" "obj" {
  algorithm = "RSA"
}

resource "acme_registration" "obj" {
  account_key_pem = tls_private_key.obj.private_key_pem
  email_address   = var.email_address
}

resource "acme_certificate" "obj" {
  account_key_pem = acme_registration.obj.account_key_pem
  common_name     = aws_route53_record.obj.fqdn

  dns_challenge {
    provider = "route53"

    config = {
      AWS_ACCESS_KEY_ID     = var.aws_access_key
      AWS_SECRET_ACCESS_KEY = var.aws_secret_key
      AWS_DEFAULT_REGION    = var.aws_region
    }
  }
}

# Store the cert on the local file system
resource "local_file" "ca" {
  sensitive_content = acme_certificate.obj.issuer_pem
  filename          = "${var.record_name}.${data.aws_route53_zone.obj.name}ca.pem"
}

resource "local_file" "priv" {
  sensitive_content = acme_certificate.obj.private_key_pem
  filename          = "${var.record_name}.${data.aws_route53_zone.obj.name}priv.pem"
}

resource "local_file" "cert" {
  sensitive_content = acme_certificate.obj.certificate_pem
  filename          = "${var.record_name}.${data.aws_route53_zone.obj.name}cert.pem"
}