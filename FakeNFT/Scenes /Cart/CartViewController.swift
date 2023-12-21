//
//  BasketViewController.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 14.12.2023.
//

import UIKit

final class CartViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let presenter: CartPresenterProtocol
    
    private lazy var nftTableView: UITableView = {
        let element = UITableView()
        element.separatorStyle = .none
        element.backgroundColor = .clear
        element.allowsSelection = false
        element.register(CartViewControllerCell.self, forCellReuseIdentifier: "CartCell")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var summaryInfoView: SummaryInfoView = {
        let view = SummaryInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sortButton = UIBarButtonItem(
        image: UIImage.Icons.sort,
        style: .plain,
        target: self,
        action: #selector(didTapsortButton)
    )
    
    
    // MARK: - Initializers

    init(presenter: CartPresenterProtocol = CartPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        nftTableView.delegate = self
        nftTableView.dataSource = self
        setNavBar()
        addViews()
        addConstraints()
        
    }
    
    
    // MARK: - Private Methods
    
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
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            summaryInfoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            summaryInfoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            summaryInfoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            nftTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nftTableView.bottomAnchor.constraint(equalTo: summaryInfoView.topAnchor),
            nftTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nftTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
        
    
    //MARK: objc func
    @objc
    private func didTapsortButton() { }
    
    
}


// MARK: - UITableViewDataSource
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.nftArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartViewControllerCell else { return UITableViewCell() }
        
        let model = presenter.nftArray[indexPath.row]
        cell.configureCell(with: model)
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

        

