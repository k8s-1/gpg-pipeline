#!/bin/bash

usage() {
    echo "Usage: $0 [OPTION]"
    echo "  --encrypt            Encrypt mode"
    echo "  --decrypt            Decrypt mode"
    exit 1
}

mode=""
if [ -z "$1" ]; then usage; fi
case "$1" in
    --encrypt) mode="encrypt" ;;
    --decrypt) mode="decrypt" ;;
    *) usage ;;
esac

if [[ "$mode" == "encrypt" ]]; then
  echo "Encrypting..."
elif [[ "$mode" == "decrypt" ]]; then
  echo "Decrypting..."
fi
