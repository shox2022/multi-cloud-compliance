output "buckets" {
  value = [for b in minio_bucket.data : b.bucket]
}