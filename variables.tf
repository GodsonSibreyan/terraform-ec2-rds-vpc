variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
    description = "Region"
    }
variable "main_vpc_cidr" {
    description = "CIDR of the VPC"
    default = "10.0.0.0/16"
}

variable "wordpressami" {
    description = "Basic amazon linux ami"
    default = "10.0.0.0/16"
}
variable "instancetype" {
    description = "Wordpress instance type"
    default = "t2.micro"
}

variable "keypair" {
    description = "ssh keypair"
    default = "Manoj"
}

variable "dbengine" {
    description = "db instance engine"
    default = "mysql"
}
variable "dbversion" {
    description = "db engine version"
    default = "5.7"
}

variable "dbinstancetype" {
    description = "rds instance type"
    default = "db.t2.micro"
}

variable "dbusername" {
    description = "db admin username"
    default = "admin"
}

variable "dbpassword" {
    description = "db admin password"
    default = "root1234"
}

