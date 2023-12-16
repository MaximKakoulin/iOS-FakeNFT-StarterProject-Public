//
//  BasketViewController.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 14.12.2023.
//

import UIKit

final class CartViewController: UIViewController {
    
    private lazy var NftTableView: UITableView = {
        let element = UITableView()
        element.separatorStyle = .singleLine
        element.layer.cornerRadius = 16
        element.isScrollEnabled = false
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
    }
    
    
    private func addViews() {
        view.backgroundColor = .ypWhite
    }
    
}

//extension CartViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//    
//}

extension CartViewController: UITableViewDelegate {
    
}


// MARK: - CartNFTCellDelegate

extension CartViewController: CartNFTCellDelegate {
    func didTapDeleteButton(on nft: NFTModel) {
        let deleteFromCartVC = DeleteFromCartViewController()
        deleteFromCartVC.nftForDelete = nft
//        deleteFromCartVC.delegate = self
        deleteFromCartVC.modalPresentationStyle = .overFullScreen
        deleteFromCartVC.modalTransitionStyle = .crossDissolve
        present(deleteFromCartVC, animated: true)
    }
}

