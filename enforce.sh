#!/usr/bin/env bash
set -e
cd terraform
terraform plan -out plan.json
terraform show -json plan.json > tfplan.json

echo "→ Scanning with OPA…"
violations=$(opa eval \
  --format json \
  --data ../policy.rego \
  "data.terraform.minio.deny" \
  --input tfplan.json | jq '.result[]?.expressions[].value')

# Log violations into SQLite
echo "$violations" \
  | python3 ../dashboard/api/log_violations.py

if [ -n "$violations" ]; then
  echo "$violations" | sed 's/^/  /'
  echo "⚠️ Violations found—aborting."
  exit 1
else
  echo "✅ No violations; applying infra."
  terraform apply plan.json
fi
