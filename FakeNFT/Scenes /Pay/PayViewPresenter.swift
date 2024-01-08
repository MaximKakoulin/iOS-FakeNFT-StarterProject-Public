//
//  PayViewPresenter.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 01.01.2024.
//

import UIKit

enum PaymentStatus {
    case notPay
    case success
    case failure
}

protocol PayViewPresenterProtocol: AnyObject {
    var currenciesArray: [CurrencyModel] { get }
    var isLoading: Bool { get }
    var paymentStatus: PaymentStatus { get }
    
    
    func showCurrency()
    func selectCurrency(with id: String)
    func performPayment()
}


final class PayViewPrsenter: PayViewPresenterProtocol {

    //MARK: - Private Properties
    var currenciesArray: [CurrencyModel] = []
    var paymentStatus: PaymentStatus = .notPay
    
    private let currencyService: CurrencyServiceProtocol

    private let cartService: CartServiceProtocol
    private var selectedCurrency: CurrencyModel?
    var isLoading: Bool = true
    private weak var view: PayViewControllerProtocoll?
    
    init(
        view: PayViewControllerProtocoll?,
        currencyService: CurrencyServiceProtocol = CurrencyService(),
         cartService: CartServiceProtocol = CartService()
    ) {
        self.view = view
        self.currencyService = currencyService
        self.cartService = cartService
    }
    
    //   MARK: - Methods
    
    private func getCurrency() {
        isLoading = true
        currencyService.getCurrencies { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let currencies):
                    self.currenciesArray = currencies
                case .failure(let error):
                    self.isLoading = false
                    print(error.localizedDescription)
                }
                self.view?.reload()
            }
        }
        isLoading = false
    }
    
    private func clearOrder() {
        isLoading = true
        cartService.updateOrder(updatedOrder: []) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let order):
                        if order.nfts.isEmpty { print("order is empty")}
                    case .failure(let error):
                        self.paymentStatus = .failure
                        self.isLoading = false
                        print(error.localizedDescription)
                }
                
            }
        }
        isLoading = false
    }
    
    func showCurrency() {
        getCurrency()
    }
    
    func selectCurrency(with id: String) {
        self.selectedCurrency = currenciesArray.first(where: { $0.id == id } )
    }
    
    func switchController() {
        switch paymentStatus {
        case .failure:
            view?.switchSuccessViewController()
        case .success:
            view?.switchFailureViewController()
        case .notPay:
            break
        }
    }
    
    func performPayment() {
        guard let id = selectedCurrency?.id else { return }
        isLoading = true
        currencyService.performPaymentOrder(with: id) { [weak self] result in
            print(result)
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    if result.success == true {
                        self.paymentStatus = .success
                        self.switchController()
                        self.clearOrder()
                    } else {
                        self.paymentStatus = .failure
                        self.switchController()
                        self.selectedCurrency = nil
                    }
                case .failure(let error):
                    self.paymentStatus = .failure
                    self.isLoading = false
                    print(error.localizedDescription)
                }
            }
        }
        isLoading = false
    }
}
