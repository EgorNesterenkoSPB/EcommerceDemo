import Foundation

struct WelcomeMyCart: Codable {
    let basket: [Basket]
    let delivery, id: String
    let total: Int
}


struct Basket: Codable {
    let id: Int
    let images: String
    let price: Int
    let title: String
}
