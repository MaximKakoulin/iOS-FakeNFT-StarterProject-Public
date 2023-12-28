//
//  CartService.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 25.12.2023.
//

import Foundation

protocol CartServiceProtocol {
    var networkClient: NetworkClient { get }
    func getOrder(completion: @escaping (Result<[String], Error>) -> Void)
    func updateOrder(updatedOrder: [String], completion: @escaping (Result<OrderModel, Error>) -> Void)
}


struct CartService: CartServiceProtocol {
    
    let networkClient: NetworkClient
    let getOrderNfts: NetworkRequest
    
    init(
        networkClient: NetworkClient = DefaultNetworkClient(),
        getOrderNFTs: NetworkRequest = GetOrderRequest()
    ) {
        self.networkClient = networkClient
        self.getOrderNfts = getOrderNFTs
    }
    
    func getOrder(completion: @escaping (Result<[String], Error>) -> Void) {
        networkClient.send(request: getOrderNfts, type: OrderModel.self) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let order):
                    completion(.success(order.nfts))
                    case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func updateOrder(updatedOrder: [String], completion: @escaping (Result<OrderModel, Error>) -> Void) {
        let putOrderRequest = PutOrderRequest(dto: ["nfts": updatedOrder])
        networkClient.send(request: putOrderRequest, type: OrderModel.self) { result in
            switch result {
                case .success(let order):
                completion(.success(order))
                case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

//TODO: - Вынести в одлеьный файл 
enum Constants {
    static let endpoint = URL(string:"https://d5dn3j2ouj72b0ejucbl.apigw.yandexcloud.net")!
}

struct GetOrderRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "https://64c51731c853c26efada7bb6.mockapi.io/api/v1/orders/1")
//        Constants.endpoint.appendingPathComponent("/api/v1/orders/1")
    }
    
    var httpMethod: HttpMethod { .get }
    
}


struct PutOrderRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "https://64c51731c853c26efada7bb6.mockapi.io/api/v1/orders/1")
//        Constants.endpoint.appendingPathComponent("/api/v1/orders/1")
    }
    
    var httpMethod: HttpMethod { .put }
    
    var dto: Encodable?
}
