##################################
# Security Groups 
#################################
resource "aws_security_group" "wp-app-sg" {
    name = "wp-app-sg"
    description = "app security group"
    vpc_id = "${aws_vpc.main.id}"
     ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = ["${aws_security_group.wp-elb-sg.id}"]
    }
     ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  egress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "wp-app-sg"
    }
    depends_on = ["aws_security_group.wp-elb-sg"]
}

resource "aws_security_group" "wp-db-sg" {
    name = "wp-db-sg"
    description = "db security group"
    vpc_id = "${aws_vpc.main.id}"
     ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = ["${aws_security_group.wp-app-sg.id}"]
    }
    egress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "wp-db-sg"
    }
    depends_on = ["aws_security_group.wp-app-sg"]
}

resource "aws_security_group" "wp-elb-sg" {
    name = "wp-elb-sg"
    description = "elb security group"
    vpc_id = "${aws_vpc.main.id}"
     ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "wp-elb-sg"
    }
}