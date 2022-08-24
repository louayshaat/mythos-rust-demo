# mythos-rust-demo
A demo to run a Rust application on Cloud Run


### Commands

#### Create new rust application

```
cargo new demo
```

#### Compile rust application

```
cargo run
```

#### Push to Container Registry

```
gcloud builds submit --tag gcr.io/core-demos/demo --timeout=2000
```

#### Enable Container Registry caching

```
gcloud config set builds/use_kaniko True
gcloud config list
```
