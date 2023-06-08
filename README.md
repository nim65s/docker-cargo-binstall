# Docker images for cargo-binstall

You can either use eg. `nim65s/cargo-binstall:mdbook` to get a bullseye with the right binary,
or build your own with eg.:

```Dockerfile
FROM nim65s/cargo-binstall as builder

RUN cargo binstall -y mdbook

FROM debian:bullseye

COPY --from=builder /usr/local/cargo/bin/mdbook /usr/local/bin/mdbook
```

## Currently available apps:

- mdbook
