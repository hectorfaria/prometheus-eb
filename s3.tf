resource "aws_s3_bucket" "docker_run_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_object" "docker_run_object" {
  key    = "${local.docker_run_config_sha}.zip"
  bucket = aws_s3_bucket.docker_run_bucket.id
  source = data.archive_file.docker_run.output_path
}
