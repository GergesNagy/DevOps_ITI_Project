output "key_name" {
  description = "The key pair name."
  value       = aws_key_pair.pub_key.key_name
}

output "key_id" {
  description = "The key pair ID."
  value       = aws_key_pair.pub_key.key_pair_id
}

output "key_fingerprint" {
  description = "The MD5 public key fingerprint as specified in section 4 of RFC 4716."
  value       = aws_key_pair.pub_key.fingerprint
}