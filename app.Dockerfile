FROM nim65s/cargo-binstall as builder

ARG APP

RUN cargo binstall -y $APP

FROM debian:bookworm

ARG APP

COPY --from=builder /usr/local/cargo/bin/$APP /usr/local/bin/$APP
