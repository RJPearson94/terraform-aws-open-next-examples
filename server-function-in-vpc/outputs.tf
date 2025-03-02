output "cloudfront_url" {
  description = "The URL for the cloudfront distribution"
  value       = module.opennext_single_zone.cloudfront_url
}