locals {
  docker_run_config_sha = sha256(local_file.docker_run_config.content)
}

data "archive_file" "docker_run" {
  type        = "zip"
  source_file = local_file.docker_run_config.filename
  output_path = "${path.module}/Dockerrun.aws.zip"
}
