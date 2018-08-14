###################################
#        Launch Configuration 
####################################

resource "aws_launch_configuration" "wordpress-lc" {
  name_prefix    = "wordpress_lc"
  image_id      = "${data.aws_ami.basic_ami.id}"
  instance_type = "${var.instancetype}"
  iam_instance_profile = "${aws_iam_instance_profile.wp-ec2-profile.name}"
  key_name = "${var.keypair}"
  security_groups = ["${aws_security_group.wp-app-sg.id}"]
  user_data          = "${data.template_file.init_template.rendered}"
  depends_on = [ "aws_security_group.wp-app-sg" ,"data.template_file.init_template" , "aws_iam_instance_profile.wp-ec2-profile"]
}

###################################
#        Auto Scaling 
####################################
resource "aws_autoscaling_group" "wp-asg" {
  name_prefix               = "wp-asg"
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.wordpress-lc.name}"
  vpc_zone_identifier       = ["${aws_subnet.subnet1.id}", "${aws_subnet.subnet2.id}"]
  load_balancers = ["${aws_elb.wordpress-elb.name}"]
  tag {
    key                 = "Name"
    value               = "wordpress-app"
    propagate_at_launch = true
  }
  depends_on = ["aws_launch_configuration.wordpress-lc", "aws_elb.wordpress-elb" ]
}


###################################
#       Load Balancer (ELB)
####################################
# Create a new load balancer
resource "aws_elb" "wordpress-elb" {
  name_prefix          = "wordpress-elb"
 # availability_zones = [ "${data.aws_availability_zones.available.names[0]}" , "${data.aws_availability_zones.available.names[1]}" ]
  security_groups = ["${aws_security_group.wp-elb-sg.id}"]
  subnets = ["${aws_subnet.subnet3.id}", "${aws_subnet.subnet4.id}"]

  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 80
    lb_protocol        = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:80"
    interval            = 30
  }
  cross_zone_load_balancing   = true
  idle_timeout                = 300
  connection_draining         = true
  connection_draining_timeout = 300

  tags {
    Name = "wp-elb-sg"
  }
}
