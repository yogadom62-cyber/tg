FROM rust:1.75 as builder

WORKDIR /app
RUN git clone https://github.com/telemt/telemt .
RUN cargo build --release

FROM debian:bookworm-slim

WORKDIR /app
COPY --from=builder /app/target/release/telemt /usr/local/bin/telemt

CMD ["telemt"]
