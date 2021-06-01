data "aws_ip_ranges" "eu_central_ip_range" {
  regions = ["eu-central-1", "eu-west-1"]
  services = ["ec2"]
}

resource "aws_security_group" "sg-custom_eu_central" {
  name = "sg-custon_eu_central"

  ingress =  {
    cidr_blocks = data.aws_ip_ranges.eu_central_ip_range.cidr_blocks
    description = "value"
    from_port = "443"
    # ipv6_cidr_blocks = [ "value" ]
    # prefix_list_ids = [ "value" ]
    protocol = "tcp"
    # security_groups = [ "value" ]
    # self = false
    to_port = "443"
  } 

  tags = {
    CreateDate = data.aws_ip_ranges.eu_central_ip_range.create_date
    SyncToken = data.aws_ip_ranges.eu_central_ip_range.sync_token 
  }
}