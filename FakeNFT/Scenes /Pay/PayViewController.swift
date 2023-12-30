//
//  PayViewController.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 28.12.2023.
//

import UIKit

final class PayViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bodyBold17
        label.text = NSLocalizedString("Select payMethod", comment: "")
        label.textColor = .ypWhite
        return label
    }()
    
    private lazy var backButton = UIBarButtonItem(
        image: UIImage.Icons.backward,
        style: .plain,
        target: self,
        action: #selector(didtapBackButton)
    )
    
    private lazy var currenciesCollection: UICollectionView = {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collection.register(
            PayViewControllerCell.self,
            forCellWithReuseIdentifier: "Cell"
        )
        collection.backgroundColor = .clear
        collection.allowsMultipleSelection = false
        return collection
    }()
    
    private lazy var payView: PayView = {
        let view = PayView()
        view.delegate = self
        return view
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        currenciesCollection.delegate = self
        currenciesCollection.dataSource = self
        
        addView()
    }
    
    
    //MARK: - Actions
    
    @objc
    func didtapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Private methods
    
    private func addView() {
        view.backgroundColor = .ypWhite
        
        [currenciesCollection, payView].forEach{
            view.addSubview($0)
        }
        
        addNavBar()
        addConstraints()
    }
    
    private func addNavBar() {
        navigationItem.titleView = titleLabel
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = .ypBlue
        navigationController?.navigationBar.backgroundColor = .ypWhite
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            currenciesCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            currenciesCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            currenciesCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            currenciesCollection.bottomAnchor.constraint(equalTo: payView.topAnchor),
            
            payView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            payView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            payView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}


//MARK: - UICollectionViewDelegate

extension PayViewController: UICollectionViewDelegate {
    
}


//MARK: - UICollectionViewDataSource

extension PayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

// MARK: - PayViewDelegate

extension PayViewController: PayViewDelegate {
    func didTapPayButton() {
//        viewModel.performPayment()
    }
    
    func didTapUserAgreementLink() {
//        let userAgreementViewController = UserAgreementViewController()
//        navigationController?.pushViewController(userAgreementViewController, animated: true)
    }
}
