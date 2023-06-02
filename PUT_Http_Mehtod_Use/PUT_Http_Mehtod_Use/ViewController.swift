//
//  ViewController.swift
//  PUT_Http_Mehtod_Use
//
//  Created by Mac on 17/05/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        putHttpMehod()
    }

    func putHttpMehod(){
        let baseUrl = "https://dummyjson.com/"
        let path = "posts/"
        let productId = "8"
        
        guard let url = URL(string: "\(baseUrl)\(path)\(productId)") else {
            print("Invalid URl")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT" // "PATCH"
        request.allHTTPHeaderFields = ["Content-Type" : "application/json"]
        
        var product = Product()
        product.title = "Product Title"
        product.userId = 24
        let body = try? JSONEncoder().encode(product)
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data, error == nil else {
                return
            }
            guard let response = response as? HTTPURLResponse,
            200...299 ~= response.statusCode else {
                return
            }
            do{
                let product = try JSONDecoder().decode(Product.self, from: data)
                print(product)
            }
            catch let err{
                print(err)
            }
        }.resume()
    }
}

struct Product: Codable{
    var id: Int?
    var title: String?
    var body: String?
    var userId: Int?
    var tags: [String]?
    var reactions: Int?
    
    init(){}
}
