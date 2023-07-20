resource "local_file" "docker_run_config" {
  content = jsonencode({
    "AWSEBDockerrunVersion" : "1",
    "Image" : {
      "Name" : "prom/prometheus",
      "Update" : "true"
    },
    "Ports" : [
      {
        "ContainerPort" : "9090",
        "HostPort" : "9090"
      }
    ]
  })
  filename = "${path.module}/Dockerrun.aws.json"
}

/* resource "aws_elastic_beanstalk_application" "prometheus" {
  name        = "ebs-prometheus"
  description = "Prometheus with Elastic beanstalk deployment"
}

resource "aws_elastic_beanstalk_environment" "prometheus_env" {
  name                = "ebs-prometheus-env"
  application         = "ebs-prometheus"
  cname_prefix        = "myprometheus"
  solution_stack_name = var.solution_stack_name

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.subnets)
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = var.instance_role
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = var.ebs_service_role
  }

}
 */
