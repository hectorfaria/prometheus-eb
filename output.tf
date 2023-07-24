output "endpoint_url" {
  description = "Endpoint for the elastic beanstalk environment"
  value       = aws_elastic_beanstalk_environment.prometheus-env.cname
}
