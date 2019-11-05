/*
module "<participant>" {
  source = "../../../modules/trusted-setup-participant/"

  server_id = "${aws_transfer_server.challenge_transfer.id}"
  role      = "${aws_iam_role.participant.arn}"
  bucket    = "${aws_s3_bucket.trusted_setup.bucket}"
  user_name = "<participant>"
  public_key = "${file("keys/<participant>.pub")}"
}
*/
