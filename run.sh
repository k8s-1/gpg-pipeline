#!/bin/bash

# will encrypt file with different armor even if no changes were made

# process:
# 1. generate files
# 2. encrypt
# 3. version control
# ...
# 1. decrypt as needed
#
#
# for file in *; do mv "$file" "${file%.*}.encrypted" done
# for file in *.encrypted; do mv "$file" "${file%.*}"; done

set -eu

GPG_PASSPHRASE=123

gpg --version

FILE="file.data"

# you need an id to traceback which encryption method was used in case rotation is needed
ENCRYPTION_ID="Security is not a product, but a process. – Bruce Schneier"

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
  rm tmp
}

decrypt
cat "$FILE"

decrypt
cat "$FILE"

encrypt
cat "$FILE"

# # for testing only
# git add "$ENCRYPTED_FILE" "$UNENCRYPTED_FILE"
# git commit -m "adding files"
# git push
