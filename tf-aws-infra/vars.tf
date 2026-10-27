variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
    type = string
    default = "eu-west-3"
    description = "EC2 instance region"
}

variable "AWS_AMIS" {
    type = map
    default = {
	"eu-west-1" = "ami-03fd334507439f4d1"
    "eu-west-2" = "ami-091f18e98bc129c4e"
    "eu-west-3" = "ami-06e02ae7bdac6b938"
    }
}

variable "INSTANCE_TYPE" {
  default = "t3.micro"
}
