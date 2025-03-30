security_group_name  = "sg_project"
security_group_ports = [22, 80, 8080, 8069, 30080, 30010, 30011]

instance_type = "t2.medium"
username      = "ubuntu"
key_name      = "key_project"
protocol      = "tcp"
region        = "eu-west-3"
stack         = "kubernetes"