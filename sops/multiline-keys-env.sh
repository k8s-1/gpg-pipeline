#!/bin/bash

# age keys as env var

# Simulate SK stored in env var
export SOPS_AGE_KEY="# created: 2025-01-20T09:28:32+01:00
# public key: age129p9qwdu8smqak0ekxgqspr9srnvkpx372p7nggyvdhfz3yllczsj456xp
AGE-SECRET-KEY-********************************"

PK=$(echo "$SOPS_AGE_KEY" | age-keygen -y /dev/stdin | head -n 1)
sops -e -i --age "$PK" test.json

sops -d -i test.json
