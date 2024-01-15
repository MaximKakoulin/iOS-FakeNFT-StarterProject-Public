//
//  CartPresenter.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 15.12.2023.
//

import Foundation

// MARK: - Protocol

protocol CartPresenterProtocol: AnyObject {
    var nftArray: [NFTModelCart] { get }
    var isLoad: Bool { get }
    var summaryInfo: SummaryInfo { get }
    var orders: [String] { get }
    func showNft()
    func checkNftArray()
    func deleteNft(_ nft: NFTModelCart, completion: @escaping () -> Void) }

protocol Sortable {
    func sort(param: Sort)
}

final class CartPresenter: CartPresenterProtocol {
    
    //MARK: - Propertirs
    
    var nftArray: [NFTModelCart] = []
    var orders: [String] = [] {
        didSet {
            self.nftArray = []
            getNFtOrder()
        }
    }
    var isLoad: Bool = true
    var summaryInfo: SummaryInfo {
        let price = nftArray.reduce(0.0) { $0 + $1.price }
        return SummaryInfo(countNft: nftArray.count, price: price)
    }
    
    
    //MARK: - Private Properties
    private let nftService: NftServiceProtocol
    private let cartService: CartServiceProtocol
    private weak var view: CartViewControllerProtocol?
    private let sortSaveService: SortSaveServiceProtocol
    
    
    
    //MARK: - Initializers
    init(
        view: CartViewControllerProtocol?,
        nftService: NftServiceProtocol = NftService(),
        cartService: CartServiceProtocol = CartService(),
        sortSaveService: SortSaveServiceProtocol = SortSaveService(screen: .cart)
    ) {
        self.view = view
        self.nftService = nftService
        self.cartService = cartService
        self.sortSaveService = sortSaveService
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
                    print(error.localizedDescription)
                }
                self.checkNftArray()
                self.view?.reload()
            }
        }
    }
    
    private func getNFtOrder() {
        isLoad = true
        if orders.isEmpty {
            isLoad = false
        } else {
            orders.forEach {
                nftService.getNft(id: $0) { [weak self] result in
                    guard let self else { return }
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let nft):
                            self.nftArray.append(nft)
                        case .failure(let error):
                            self.isLoad = false
                            print(error.localizedDescription)
                        }
                        self.checkNftArray()
                        self.view?.reload()
                    }
                }
            }
            isLoad = false
        }
    }
    
    func deleteNft(_ nft: NFTModelCart, completion: @escaping () -> Void) {
        isLoad = true
        let updatedOrder = orders.filter { $0 != nft.id }
        cartService.updateOrder(updatedOrder: updatedOrder) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let order):
                    self.orders = order.nfts
                    self.nftArray = self.nftArray.filter { updatedOrder.contains($0.id) }
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        isLoad = false
    }  
    
    
    func checkNftArray() {
        print(orders)
        if orders.isEmpty {
            view?.showEmptyCartPlaceholder()
        } else {
            view?.showCart()
        }
    }
}




// MARK: - Sortable

extension CartPresenter: Sortable {
    func sort(param: Sort) {
        sortSaveService.saveSorting(param: param)
        switch param {
            case .price:
                nftArray = nftArray.sorted(by: {$0.price > $1.price} )
                view?.reload()
            case .rating:
                nftArray = nftArray.sorted(by: {$0.rating > $1.rating} )
                view?.reload()
            case .NFTName:
                nftArray = nftArray.sorted(by: {$0.name < $1.name} )
                view?.reload()
            case .NFTCount:
                break
            case .name:
                break
        }
    }
}
