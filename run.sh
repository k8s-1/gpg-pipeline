#!/bin/bash
set -eu

GPG_PASSPHRASE=123

gpg --version

FILE="file.data"
ENCRYPTION_ID="self-rolled-caesar"

# conditionally unencrypt if encryption id is present
function decrypt() {
  if [ -f "$FILE" ]; then
    HEAD=$(head -n 1 "$FILE")
  fi

  if [[ "$HEAD" == "$ENCRYPTION_ID" ]]; then
    echo "$FILE is encrypted with $ENCRYPTION_ID"
    echo "Unencrypting it..."
    sed -i '1d' "$FILE"
    gpg --batch --yes --passphrase "$GPG_PASSPHRASE" --armor --output tmp --decrypt "$FILE"
    mv tmp "$FILE"
    cat "$FILE"
  else
    echo "$FILE is not encrypted...skipping"
  fi
}

# encrypt
function encrypt() {
  echo "Encrypting $FILE..."
  gpg --batch --yes --passphrase "$GPG_PASSPHRASE" --armor --output tmp --symmetric --cipher-algo AES256 "$FILE"
  echo "$ENCRYPTION_ID" | cat - tmp > "$FILE"
}

decrypt
cat "$FILE"

decrypt
cat "$FILE"

# encrypt
# cat "$FILE"

# # for testing only
# git add "$ENCRYPTED_FILE" "$UNENCRYPTED_FILE"
# git commit -m "adding files"
# git push
