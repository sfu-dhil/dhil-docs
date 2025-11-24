# DHIL Docs

Builds the DJIL docs (including privacy policy, etc)

## Requirements

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

## Run

```bash
docker compose up -d --build
```

Visit `http://localhost:8080`

### Teardown

```bash
docker compose down
```


## Update Deps/Gemfile.lock

```bash
docker run -it --rm -w /app -v $(pwd):/app ruby:3.3 bundle update
```