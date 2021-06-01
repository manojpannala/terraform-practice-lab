data "aws_ip_ranges" "eu_central_ip_range" {
  regions = ["eu-central-1", "eu-west-1"]
  services = ["ec2"]
}

resource "aws_security_group" "sg-custom_eu_central" {
  name = "custom_eu_central"

  ingress {
    cidr_blocks = slice(data.aws_ip_ranges.eu_central_ip_range.cidr_blocks, 0, 20)
    description = "value"
    from_port = "443"
    protocol = "tcp"
    to_port = "443"
  } 

  tags = {
    CreateDate = data.aws_ip_ranges.eu_central_ip_range.create_date
    SyncToken = data.aws_ip_ranges.eu_central_ip_range.sync_token 
  }
}