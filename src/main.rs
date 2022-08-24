use std::fmt::format;

use actix_web::{get, web, App, HttpServer, Responder};

#[get("/hello/{name}")]
async fn greet(name: web::Path<String>) -> impl Responder {
    format!("Hello {}!", name)
}

#[actix_web::main] // or #[tokio::main]
async fn main() -> std::io::Result<()> {


    let port = match std::env::var("PORT"){
        Ok(port) => port,
        _ => String::from("8080")
    };

    let address = format!("0.0.0.0:{}",port);
    

    HttpServer::new(|| {
        App::new()
            .route("/hello", web::get().to(|| async { "Hello World!" }))
            .service(greet)
    })
    .bind(address.clone ())?
    .run()
    .await
}