module "ec2_cluster" {
    source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"

    name = "my-cluster"
    ami = "ami-0980c5102b5ef10cc"
    instance_type = "t2.micro"
    subnet_id = "subnet-a6c342ea"

    tags = {
        Terraform = "true"
        Environment = "dev"
    }
}