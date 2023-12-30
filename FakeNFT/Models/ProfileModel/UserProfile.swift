//
//  UserProfile.swift
//  FakeNFT
//
//  Created by Максим on 17.12.2023.
//

import Foundation

struct UserProfile: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let likes: [String]
    let id: String
}
