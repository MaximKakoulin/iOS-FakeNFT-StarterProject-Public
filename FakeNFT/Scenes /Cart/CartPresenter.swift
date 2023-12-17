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
final class CartPresenter {
    var nftArray: [NFTModel] = []
}
