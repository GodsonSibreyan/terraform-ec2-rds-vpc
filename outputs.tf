################### 
#    OUTPUTS 
##################

 output "Rds-Endpoint" {
   value = "${aws_db_instance.wordpress-db.endpoint}"
 }
 output " ELB_DNS" {
   value = "${aws_elb.wordpress-elb.dns_name}"
 }