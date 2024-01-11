//
//  CurrencyService.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 01.01.2024.
//

import UIKit

protocol CurrencyServiceProtocol {
    var networkClient: NetworkClient { get }
    func getCurrencies(completion: @escaping (Result<[CurrencyModel], Error>) -> Void)
    func performPaymentOrder(with currencyID: String, completion: @escaping (Result<PaymentCurrencyModel, Error>) -> Void)
}


struct CurrencyService: CurrencyServiceProtocol {
    
    let networkClient: NetworkClient
    let request: NetworkRequest
    
    init(
        networkClient: NetworkClient = DefaultNetworkClient(),
        request: NetworkRequest = GetCurrenciesRequest()
    ) {
        self.networkClient = networkClient
        self.request = request
    }
    
    func getCurrencies(completion: @escaping (Result<[CurrencyModel], Error>) -> Void) {
        networkClient.send(request: request, type: [CurrencyModel].self) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let currencies):
                    completion(.success(currencies))
                    case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func performPaymentOrder(with currencyID: String, completion: @escaping (Result<PaymentCurrencyModel, Error>) -> Void) {
        let paymentOrderRequest = PaymentOrderRequest(id: currencyID)
        networkClient.send(request: paymentOrderRequest, type: PaymentCurrencyModel.self) { result in
            switch result {
                case .success(let payment):
                completion(.success(payment))
                case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


struct GetCurrenciesRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "https://64c51731c853c26efada7bb6.mockapi.io/api/v1/currencies")
//        Constants.endpoint.appendingPathComponent("/currencies")
    }
    
    var httpMethod: HttpMethod { .get }
}

struct PaymentOrderRequest: NetworkRequest {
    private let id: String
    
    var endpoint: URL? {
        URL(string: "https://64c51731c853c26efada7bb6.mockapi.io/api/v1/orders/1/payment/\(id)")
//        Constants.endpoint.appendingPathComponent("/orders/1/payment/\(id)")
    }
    
    var httpMethod: HttpMethod { .get }
    
    init(id: String) {
        self.id = id
    }
}


