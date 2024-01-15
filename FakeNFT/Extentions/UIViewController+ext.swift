//
//  UIViewController+ext.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 09.01.2024.
//

import UIKit

enum Sort {
    case price
    case rating
    case name
    case NFTCount
    case NFTName
}

enum SortForScreen {
    case cart
}


extension UIViewController {
    
    func showAlertSort(presenter: Sortable, valueSort: SortForScreen) {
        
        let alert = UIAlertController(
            title: nil,
            message: NSLocalizedString("Sorting", comment: ""),
            preferredStyle: .actionSheet
        )
        
        let sortByPriceAction = UIAlertAction(title: NSLocalizedString("By price", comment: ""), style: .default) { _ in
            presenter.sort(param: .price)
        }
        
        let sortByRatingAction = UIAlertAction(title: NSLocalizedString("By rating", comment: ""), style: .default) { _ in
            presenter.sort(param: .rating)
        }

        let sortByNFTNameAction = UIAlertAction(title: NSLocalizedString("By NFT name", comment: ""), style: .default) { _ in
            presenter.sort(param: .NFTName)
        }
        
        let closeAction = UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .cancel)
        
        switch valueSort {
            case .cart:
            alert.addAction(sortByPriceAction)
            alert.addAction(sortByRatingAction)
            alert.addAction(sortByNFTNameAction)
        }
       
        alert.addAction(closeAction)
        
        present(alert, animated: true)
    }
}
