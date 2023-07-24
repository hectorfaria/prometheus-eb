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

resource "aws_elastic_beanstalk_application" "prometheus" {
  name        = "ebs-prometheus"
  description = "Prometheus with Elastic beanstalk deployment"
}

resource "aws_elastic_beanstalk_application_version" "app_version" {
  name        = local.docker_run_config_sha
  application = aws_elastic_beanstalk_application.prometheus.name
  description = "Elastic Beanstalk running Prometheus on Docker"
  bucket      = aws_s3_bucket.docker_run_bucket.id
  key         = aws_s3_object.docker_run_object.id
}

resource "aws_elastic_beanstalk_environment" "prometheus-env" {
  name                = "prometheus-env"
  application         = aws_elastic_beanstalk_application.prometheus.name
  solution_stack_name = var.solution_stack_name
  version_label       = aws_elastic_beanstalk_application_version.app_version.name
  cname_prefix        = "prometheus-app"

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = aws_iam_instance_profile.beanstalk_service.name
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.beanstalk_ec2.name
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.max_instances
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = 200
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "HealthCheckPath"
    value     = "/status"
  }

}
