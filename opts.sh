#!/bin/bash

# Encrypt / decrypt all JSON, YAML, INI, ENV files recursively 
#
# Requires environment variable:
# AGE_SK_FILE_CONTENTS

usage() {
    echo "Usage: $0 [OPTION]"
    echo "  --encrypt            Encrypt mode"
    echo "  --decrypt            Decrypt mode"
    exit 1
}

encrypt() {
  echo "Encrypting..."
}

decrypt() {
  echo "Decrypting..."
}

if [ -z "$1" ]; then usage; fi
case "$1" in
    --encrypt) encrypt ;;
    --decrypt) decrypt ;;
    *) usage ;;
esac
