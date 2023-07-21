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
}

resource "aws_elastic_beanstalk_environment" "prometheus-env" {
  name                = "prometheus-env"
  application         = aws_elastic_beanstalk_application.prometheus.name
  solution_stack_name = var.solution_stack_name
  version_label = aws_elastic_beanstalk_application_version.app_version.name
  cname_prefix = "prometheus-app"
}
