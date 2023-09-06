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
