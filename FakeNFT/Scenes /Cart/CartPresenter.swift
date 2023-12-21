//
//  CartPresenter.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 15.12.2023.
//

import Foundation

protocol CartPresenterProtocol: AnyObject {
    var nftArray: [NFTModel] { get }
}
final class CartPresenter: CartPresenterProtocol {
    var summaryInfo: SummaryInfo {
        let price = nftArray.reduce(0.0) { $0 + $1.price }
        return SummaryInfo(countNFT: nftArray.count, price: price)
    }
    
    //mok data for test
    var nftArray: [NFTModel] = [
        NFTModel(
            createdAt: "2023-04-20T02:22:27Z",
            name: "April",
            images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png",
                     "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/2.png",
                     "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/3.png"],
            rating: 4,
            description: "A 3D model of a mythical creature.",
            price: 4.4,
            author: "6",
            id: "1"),
        
        NFTModel(
            createdAt: "2023-04-20T02:22:27Z",
            name: "April",
            images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png",
                     "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/2.png",
                     "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/3.png"],
            rating: 3,
            description: "A 3D model of a mythical creature.",
            price: 4.5,
            author: "6",
            id: "1")
    ]
}
