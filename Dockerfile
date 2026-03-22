FROM rust:1.75 as builder

WORKDIR /app
RUN apt update && apt install -y git curl
RUN rustup install nightly && rustup default nightly
RUN git clone https://github.com/telemt/telemt .
RUN cargo build --release

FROM debian:bookworm-slim

WORKDIR /app
RUN apt update && apt install -y ca-certificates && update-ca-certificates

COPY --from=builder /app/target/release/telemt /usr/local/bin/telemt
COPY config.toml /app/config.toml

CMD ["telemt", "-c", "/app/config.toml"]
