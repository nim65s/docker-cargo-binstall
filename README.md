# Docker for cargo-binstall

usage eg. with mdbook:

```Dockerfile
FROM nim65s/cargo-binstall as builder

RUN cargo binstall -y mdbook

FROM debian:bullseye

COPY --from=builder /usr/local/cargo/bin/mdbook /usr/local/bin/mdbook
```
