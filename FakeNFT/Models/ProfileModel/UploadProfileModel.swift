//
//  UploadProfileModel.swift
//  FakeNFT
//
//  Created by Максим on 23.12.2023.
//

import Foundation

struct UploadProfileModel: Encodable {
    let name: String?
    let description: String?
    let website: String?
    let likes: [String]?
}
