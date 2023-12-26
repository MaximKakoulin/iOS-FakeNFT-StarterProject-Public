//
//  CartPresenter.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 15.12.2023.
//

import Foundation

// MARK: - Protocol

protocol CartPresenterProtocol: AnyObject {
    var nftArray: [NFTModel] { get }
    var isLoad: Bool { get }
    var summaryInfo: SummaryInfo { get }
    var orders: [String] { get }
    func showNft()
}


final class CartPresenter: CartPresenterProtocol {
    //MARK: - Propertirs
    var nftArray: [NFTModel] = []
    var orders: [String] = [] {
        didSet {
            self.nftArray = []
            getNFtOrder()
        }
    }
    var isLoad: Bool = true
    var summaryInfo: SummaryInfo {
        let price = nftArray.reduce(0.0) { $0 + $1.price }
        return SummaryInfo(countNFT: nftArray.count, price: price)
    }
    
    
    //MARK: - Private Properties
    private let nftService: NftServiceProtocol
    private let cartService: CartServiceProtocol
    
    
    
    //MARK: - Initializers
    init(
        nftService: NftServiceProtocol = NftService(),
        cartService: CartServiceProtocol = CartService()
    ) {
        self.nftService = nftService
        self.cartService = cartService
        getOrders()
    }
    
    func showNft() {
        getOrders()
    }
    
    
    //MARK: - Private Methods
    private func getOrders() {
        isLoad = true
        nftArray = []
        cartService.getOrder { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let order):
                    self.orders = order
                case .failure(let error):
                    self.isLoad = false
                    fatalError("Problem whith order \(error)")
                }
            }
        }
    }
    
    private func getNFtOrder() {
        isLoad = true
        if orders.isEmpty {
            isLoad = false
        } else {
            orders.forEach {
                nftService.getNFT(id: $0) { [weak self] result in
                    guard let self else { return }
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let nft):
                            self.nftArray.append(nft)
                        case .failure(let error):
                            self.isLoad = false
                            fatalError("Problem woth nft: \(error)")
                        }
                        
                    }
                }
            }
            isLoad = false
        }
    }
    
    
    
}
