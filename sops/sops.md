# run it in docker
docker run -i ghcr.io/getsops/sops:v3.9.2 -h

docker run -w /code -v $(pwd):/code -it ghcr.io/getsops/sops:v3.9.2
