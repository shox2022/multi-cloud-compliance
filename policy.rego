package terraform.minio

# 1) Must have SSE
deny[msg] {
  rc := input.resource_changes[_]
  rc.type == "minio_bucket"
  not rc.change.after.server_side_encryption_configuration
  msg = sprintf("❌ %v missing SSE", [rc.address])
}

# 2) Bucket tag must match endpoint
deny[msg] {
  rc := input.resource_changes[_]
  rc.type == "minio_bucket"
  tag := rc.change.after.tags.jurisdiction
  ep  := rc.provider_config.endpoint
  not ((tag == "EU" & ep == "http://localhost:9001") |
       (tag == "US" & ep == "http://localhost:9002"))
  msg = sprintf("❌ %v tag/jurisdiction mismatch vs %v", [rc.address, ep])
}