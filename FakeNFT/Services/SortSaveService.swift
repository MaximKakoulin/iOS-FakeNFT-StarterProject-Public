//
//  SortSaveService.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 09.01.2024.
//

import Foundation

protocol SortSaveServiceProtocol {
    var savedSorting: Sort { get }
    func saveSorting(param: Sort)
}


final class SortSaveService: SortSaveServiceProtocol {
    
    private var screen: SortForScreen
    
    init(screen: SortForScreen) {
        self.screen = screen
    }
    
    var savedSorting: Sort {
        var sorting = Sort.name
        
        if sortConfig == "price" { sorting = .price }
        if sortConfig == "rating" { sorting = .rating }
        if sortConfig == "NFTName" { sorting = .NFTName }
        if sortConfig == "NFTCount" { sorting = .NFTCount }
        if sortConfig == "name" { sorting = .name }
        
        if sortConfig == nil {
            switch screen {
            case .cart:
                sorting = .NFTName
            }
        }
        return sorting
    }
    
    private let userDefaults = UserDefaults.standard
    
    private enum Keys: String {
        case sortConfigCatalogue, sortConfigProfile, sortConfigCart, sortConfigStatistic
    }
    
    private var sortConfig: String? {
        switch screen {
        case .cart:
            return userDefaults.string(forKey: Keys.sortConfigCart.rawValue)
        }
    }
    
    func saveSorting(param: Sort) {
        switch screen {
        case .cart:
            saveSortingForScreen(param: param, key: Keys.sortConfigCart.rawValue)
        }
    }
    
    private func saveSortingForScreen(param: Sort, key: String) {
        switch param {
        case .price:
            userDefaults.set("price", forKey: key)
        case .rating:
            userDefaults.set("rating", forKey: key)
        case .name:
            userDefaults.set("name", forKey: key)
        case .NFTCount:
            userDefaults.set("NFTCount", forKey: key)
        case .NFTName:
            userDefaults.set("NFTName", forKey: key)
        }
    }
}
