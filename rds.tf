#####################
#      RDS
####################

resource "aws_db_subnet_group" "wp-db-subnet-group" {
  name       = "wp-db-subnet-group"
  subnet_ids = ["${aws_subnet.subnet5.id}", "${aws_subnet.subnet6.id}"]

  tags {
    Name = "wp-db-subnet-group"
  }
}

resource "aws_db_instance" "wordpress-db" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "${var.dbengine}"
  engine_version       = "${var.dbversion}"
  instance_class       = "${var.dbinstancetype}"
  name                 = "wpapp"
  username             = "${var.dbusername}"
  password             = "${var.dbpassword}"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name =  "${aws_db_subnet_group.wp-db-subnet-group.id}"
  multi_az =  "false"
  publicly_accessible = "false"
  vpc_security_group_ids = [ "${aws_security_group.wp-db-sg.id}" ] 
  identifier = "wordpress-db"
  skip_final_snapshot = "true"
}
