# Docker images for cargo-binstall

You can either use eg. `nim65s/cargo-binstall:mdbook` to get a bookworm container with the right binary for your CI,
or build your own with eg.:

```Dockerfile
FROM nim65s/cargo-binstall as builder

RUN cargo binstall -y mdbook

FROM debian:bookworm

COPY --from=builder /usr/local/cargo/bin/mdbook /usr/local/bin/mdbook
```

## Currently available apps:

- mdbook

## Example deployment with Github Actions & Github Pages:

```yaml
name: Build and Deploy book

on:
  push:
    branches:
      - main

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    container:
      image: nim65s/cargo-binstall:mdbook
    steps:
      - name: Checkout 🛎️
        uses: actions/checkout@v4
      - name: Build ⚙️
        run: mdbook build
      - name: Deploy 🚀
        uses: JamesIves/github-pages-deploy-action@v4
        with:
          folder: book
        permissions:
          contents: write
```

## Example deployment with Gitlab CI and rsync

```yaml
image: nim65s/cargo-binstall:mdbook

build:
  stage: build
  script:
    - mdbook build
  artifacts:
    paths:
      - book

deploy:
  stage: deploy
  only:
    refs:
      - main@your-org/your-project
  before_script:
    - mkdir -p ~/.ssh
    - ssh-keyscan "your-hostname.tld" > ~/.ssh/known_hosts
    - chmod 700 ~/.ssh
    - chmod 600 ~/.ssh/known_hosts
    - eval $(ssh-agent -s)
    - echo "$SSH_DEPLOY_KEY" | ssh-add -
  script:
    - chmod -R a+rX,g+w book
    - chown -R your-uid:your-gid book
    - rsync -avzP --delete book/ your-user@your-hostname.tld:/where/you/want
```
