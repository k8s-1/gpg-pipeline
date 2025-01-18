# gpg-pipeline

## Generate a strong password to encrypt + decrypt
- numbers
- upper + lowercase
- characters
- symbols
- random
```
pwgen -nycs 100 1
```

## To Encrypt:
```
export GPG_PASSPHRASE="your-strong-passphrase"
gpg --batch --yes --passphrase "$GPG_PASSPHRASE" --armor --output encrypted.data --symmetric --cipher-algo AES256 unencrypted.data
```

## To Decrypt:
```
export GPG_PASSPHRASE="your-strong-passphrase"
gpg --batch --yes --passphrase "$GPG_PASSPHRASE" --armor --output unencrypted.data --decrypt encrypted.data
```
