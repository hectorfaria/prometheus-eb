locals {
  docker_run_config_sha = sha256(local_file.docker_run_config.content)
}