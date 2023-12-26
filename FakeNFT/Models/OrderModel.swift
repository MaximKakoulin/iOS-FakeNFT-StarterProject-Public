//
//  OrderModel.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 25.12.2023.
//

import Foundation


struct OrderModel: Codable {
    let nfts: [String]
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case nfts
        case id
    }
}
