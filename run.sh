#!/bin/bash

GPG_PASSPHRASE=123

gpg --version

ENCRYPTED_FILE="data.enc"
UNENCRYPTED_FILE="unencrypted.data"
ENCRYPTION_ID="encryption-id-187#"

# conditionally unencrypt if encryption id is present
if [ -f "$ENCRYPTED_FILE" ]; then
  start=$(head -c "${#ENCRYPTION_ID}" "$ENCRYPTED_FILE")
fi

if [[ "$start" == "$ENCRYPTION_ID" ]]; then
  echo "$ENCRYPTED_FILE is encrypted with $ENCRYPTION_ID"
  echo "Unencrypting it..."
  gpg --batch --yes --passphrase "$GPG_PASSPHRASE" --armor --output "$UNENCRYPTED_FILE" --decrypt "$ENCRYPTED_FILE"
  cat "$UNENCRYPTED_FILE"
else
  echo "No match"
fi

# encrypt
echo "$ENCRYPTION_ID" > "$ENCRYPTED_FILE"
gpg --batch --yes --passphrase "$GPG_PASSPHRASE" --armor --output tmp --symmetric --cipher-algo AES256 "$UNENCRYPTED_FILE"
cat tmp >> "$ENCRYPTED_FILE"

# for testing only
git add "$ENCRYPTED_FILE" "$UNENCRYPTED_FILE"
git commit -m "adding files"
git push
