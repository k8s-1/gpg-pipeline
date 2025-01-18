# age
Generate a new private-pub key
age-keygen -o key.txt

# without docker
sops encrypt --age age1yt3tfqlfrwdwx0z0ynwplcr6qxcxfaqycuprpmy89nr83ltx74tqdpszlw test.yaml > test.enc.yam

# run it in docker
docker run -i ghcr.io/getsops/sops:v3.9.2 -h

docker run -w /code -v $(pwd):/code -it ghcr.io/getsops/sops:v3.9.2 encrypt --age age1yt3tfqlfrwdwx0z0ynwplcr6qxcxfaqycuprpmy89nr83ltx74tqdpszlw test.yaml > test.enc.yam


# easy decrypt
When decrypting a file with the corresponding identity, SOPS will look for a text file name keys.txt located in a sops subdirectory of your user configuration directory. On Linux, this would be $XDG_CONFIG_HOME/sops/age/keys.txt. If $XDG_CONFIG_HOME is not set $HOME/.config/sops/age/keys.txt is used instead. On macOS, this would be $HOME/Library/Application Support/sops/age/keys.txt. On Windows, this would be %AppData%\sops\age\keys.txt. You can specify the location of this file manually by setting the environment variable SOPS_AGE_KEY_FILE. Alternatively, you can provide the key(s) directly by setting the SOPS_AGE_KEY environment variable.

The contents of this key file should be a list of age X25519 identities, one per line. Lines beginning with # are considered comments and ignored. Each identity will be tried in sequence until one is able to decrypt the data.
