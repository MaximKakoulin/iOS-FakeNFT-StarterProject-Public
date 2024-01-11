//
//  CurrencyModel.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 30.12.2023.
//

import Foundation


struct CurrencyModel: Codable {
    let title: String
    let name: String
    let image: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case name
        case image
        case id
    }
}
