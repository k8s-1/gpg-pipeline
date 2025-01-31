# more secure:
$ cat encrypted-data | sops decrypt /dev/stdin > decrypted-data

# age
Generate a new private-pub key
age-keygen -o key.txt

# without docker + -i flag for in-place encryption
PK=age1c6ejj2rcwuxr77pscn5qsfmzp7jtrr0z0qut0yddxayqy0ku7p5qjnz46c
sops encrypt -i --age "$PK" test.yaml
sops decrypt -i test.yaml

# run it in docker
docker run -i ghcr.io/getsops/sops:v3.9.2 -h

## encrypt in docker
PK=age1c6ejj2rcwuxr77pscn5qsfmzp7jtrr0z0qut0yddxayqy0ku7p5qjnz46c
docker run \
    -w /code \
    -v $(pwd):/code \
    -it ghcr.io/getsops/sops:v3.9.2 encrypt -i --age "$PK" test.yaml

## decrypt in docker
docker run \
    -w /code \
    -e SOPS_AGE_KEY_FILE=./keys.txt \
    -v $(pwd):/code \
    -it ghcr.io/getsops/sops:v3.9.2 decrypt -i test.yaml

## it's fine to rotate frequently (e.g. daily), but NOT NECESSARY in most cases: https://security.stackexchange.com/questions/260241/why-is-it-important-to-rotate-symmetric-keys, usually done by people who do not understand it and want to maximize every part of security
## less is more!
### rotation impacts performance, it's not the same as re-encryption (generating a new SK to swap out the old SK), it simply involves running the encryption cipher against the data again to increase our entropy and avoid collision, very unlikely unless you're encrypting petabytes of files
sops rotate -i test.yaml

# easy decrypt
When decrypting a file with the corresponding identity, SOPS will look for a text file name keys.txt located in a sops subdirectory of your user configuration directory. On Linux, this would be $XDG_CONFIG_HOME/sops/age/keys.txt. If $XDG_CONFIG_HOME is not set $HOME/.config/sops/age/keys.txt is used instead. On macOS, this would be $HOME/Library/Application Support/sops/age/keys.txt. On Windows, this would be %AppData%\sops\age\keys.txt. You can specify the location of this file manually by setting the environment variable SOPS_AGE_KEY_FILE. Alternatively, you can provide the key(s) directly by setting the SOPS_AGE_KEY environment variable.

The contents of this key file should be a list of age X25519 identities, one per line. Lines beginning with # are considered comments and ignored. Each identity will be tried in sequence until one is able to decrypt the data.


# supported files
YAML, JSON, ENV, INI
