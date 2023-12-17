//
//  BasketViewController.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 14.12.2023.
//

import UIKit

final class CartViewController: UIViewController {
    
    private var presenter: CartPresenterProtocol?
    
    private lazy var NftTableView: UITableView = {
        let element = UITableView()
        element.separatorStyle = .singleLine
        element.layer.cornerRadius = 16
        element.isScrollEnabled = false
        element.register(CartViewControllerCell.self, forCellReuseIdentifier: "CartCell")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    private lazy var sortButton = UIBarButtonItem(
        image: UIImage.Icons.sort,
        style: .plain,
        target: self,
        action: #selector(didTapsortButton)
    )
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
    }
    
    
    private func addViews() {
        view.backgroundColor = .ypWhite
    }
        
    
    //MARK: objc func
    @objc
    private func didTapsortButton() { }
    
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.nftArray.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartViewControllerCell else { return UITableViewCell() }
        
        if let model = presenter?.nftArray[indexPath.row]{
            cell.configureCell(with: model)
        }
        cell.delegate = self
        
        return cell
    }
    
    
}

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

        

