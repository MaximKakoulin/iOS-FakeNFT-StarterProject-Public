//
//  BasketViewController.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 14.12.2023.
//

import UIKit

protocol CartViewControllerProtocol: AnyObject {
    func reload()
    //    var nftArray: [NFTModel] { get }
}

final class CartViewController: UIViewController, CartViewControllerProtocol {
    
    // MARK: - Properties
    
    var presenter: CartPresenterProtocol?
    
    // MARK: - Private Properties
    
    private lazy var nftTableView: UITableView = {
        let element = UITableView()
        element.separatorStyle = .none
        element.backgroundColor = .ypWhite
        element.allowsSelection = false
        element.register(CartViewControllerCell.self, forCellReuseIdentifier: "CartCell")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var summaryInfoView: SummaryInfoView = {
        let view = SummaryInfoView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Cart is empty", comment: "")
        label.textColor = .ypBlack
        label.font = UIFont.bodyBold17
        label.isHidden = true
        return label
    }()
    
    private lazy var sortButton = UIBarButtonItem(
        image: UIImage.Icons.sort,
        style: .plain,
        target: self,
        action: #selector(didTapsortButton)
    )
    
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nftTableView.delegate = self
        nftTableView.dataSource = self
        checkNftArray()
        setNavBar()
        addViews()
        addConstraints()
        presenter?.showNft()
        presenter = CartPresenter(view: self)
    }
    
    // MARK: - Methods
    
    func reload() {
        nftTableView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func checkNftArray() {
        
        if presenter?.orders == nil {
            showEmptyCartPlaceholder()
        } else {
            showCart()
        }
    }
    
    private func showEmptyCartPlaceholder() {
        emptyLabel.isHidden = false
        navigationController?.navigationBar.isHidden = true
        nftTableView.isHidden = true
        summaryInfoView.isHidden = true
    }
    
    private func showCart() {
        emptyLabel.isHidden = true
        navigationController?.navigationBar.isHidden = false
        nftTableView.isHidden = false
        summaryInfoView.isHidden = false
    }
    
    
    private func setNavBar() {
        navigationItem.rightBarButtonItem = sortButton
        navigationController?.navigationBar.tintColor = .ypBlack
        navigationController?.navigationBar.backgroundColor = .ypWhite
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    private func addViews() {
        view.backgroundColor = .ypWhite
        view.addSubview(nftTableView)
        view.addSubview(summaryInfoView)
        view.addSubview(emptyLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            summaryInfoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            summaryInfoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            summaryInfoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            nftTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nftTableView.bottomAnchor.constraint(equalTo: summaryInfoView.topAnchor),
            nftTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nftTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            emptyLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    
    //MARK: objc func
    @objc
    private func didTapsortButton() { }
    
    
}


// MARK: - UITableViewDataSource
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.nftArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartViewControllerCell else { return UITableViewCell() }
        
        
        if let model = presenter?.nftArray[indexPath.row] {
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
        deleteFromCartVC.delegate = self
        deleteFromCartVC.modalPresentationStyle = .overFullScreen
        deleteFromCartVC.modalTransitionStyle = .crossDissolve
        present(deleteFromCartVC, animated: true)
    }
}

// MARK: - DeleteFromCartViewControllerDelegate

extension CartViewController: DeleteFromCartViewControllerDelegate {
    func didTapReturnButton() {
        dismiss(animated: true)
    }
    
    func didTapDeleteButton(_ model: NFTModel) {
        presenter?.deleteNft(model) { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}


// MARK: - SummaryViewDelegate

extension CartViewController: SummaryViewDelegate {
    func didTapToPayButton() {
        let checkPayVC = PayViewController()
        checkPayVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(checkPayVC, animated: true)
    }
}


