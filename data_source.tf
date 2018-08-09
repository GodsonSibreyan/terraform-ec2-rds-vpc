#################
# AMI  (amazon linux)
##########
data "aws_ami" "basic_ami" {
  most_recent      = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }
   filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  owners     = ["amazon"]
}


#################
# Region 
###################
data "aws_region" "current" {}

########################
# Availability Zones 
#######################
data "aws_availability_zones" "available" {}

###################################
#      User Data
###############################
data "template_file" "init_template" {
  template = "${file("userdata.txt")}"
  vars {
    db_name        = "${aws_db_instance.wordpress-db.name}"
    db_host        = "${aws_db_instance.wordpress-db.address}"
    db_user        = "${var.dbusername}"
    db_password    = "${var.dbpassword}"
  }
  depends_on = ["aws_db_instance.wordpress-db"]
}
