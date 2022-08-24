# 1 - Compute a recipe file
FROM rust as planner
WORKDIR app
RUN cargo install cargo-chef
COPY . .
RUN cargo chef prepare --recipe-path recipe.json

# 2 - Cache Dependancies
FROM rust as cacher
WORKDIR app
RUN cargo install cargo-chef
COPY --from=planner /app/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json

# 3 - builder
FROM rust as builder

# 4 - app copy
COPY . /app
WORKDIR /app

# 5 - copy the dependancies
COPY --from=cacher /app/target target
COPY --from=cacher /usr/local/cargo /usr/local/cargo

# 6 - build the app
RUN cargo build --release

# 7 - set the as
FROM gcr.io/distroless/cc-debian11

# 8 - copy the runtime files
COPY --from=builder /app/target/release/demo /app/demo
WORKDIR /app

# 9 - Start the server
CMD ["./demo"]