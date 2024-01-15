//
//  PaymentCurrencyModel.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 01.01.2024.
//

import Foundation


struct PaymentCurrencyModel: Codable {
    let success: Bool
    let orderId: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case orderId
        case id
    }
}
