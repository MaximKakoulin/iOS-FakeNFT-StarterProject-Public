//
//  NFTModel.swift
//  FakeNFT
//
//  Created by Максим on 27.12.2023.
//

import Foundation

struct NFTModel: Decodable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let id: String
}
