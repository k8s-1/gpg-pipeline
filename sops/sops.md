# without docker
sops encrypt --age age1yt3tfqlfrwdwx0z0ynwplcr6qxcxfaqycuprpmy89nr83ltx74tqdpszlw test.yaml > test.enc.yam

# run it in docker
docker run -i ghcr.io/getsops/sops:v3.9.2 -h

docker run -w /code -v $(pwd):/code -it ghcr.io/getsops/sops:v3.9.2 encrypt --age age1yt3tfqlfrwdwx0z0ynwplcr6qxcxfaqycuprpmy89nr83ltx74tqdpszlw test.yaml > test.enc.yam
