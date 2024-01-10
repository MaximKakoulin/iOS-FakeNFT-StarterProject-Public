//
//  PayViewController.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 28.12.2023.
//

import UIKit

protocol PayViewControllerProtocoll: AnyObject {
    func reload()
    func switchSuccessViewController()
    func switchFailureViewController()
}

final class PayViewController: UIViewController, PayViewControllerProtocoll {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bodyBold17
        label.text = NSLocalizedString("Select payMethod", comment: "")
        label.textColor = .ypBlack
        label.sizeToFit()
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
            forCellWithReuseIdentifier: "cell"
        )
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.allowsMultipleSelection = false
        return collection
    }()
    
    private lazy var payView: PayView = {
        let view = PayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private var presenter: PayViewPresenterProtocol?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        currenciesCollection.delegate = self
        currenciesCollection.dataSource = self
        
        addView()
        presenter?.showCurrency()
        presenter = PayViewPrsenter(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.showCurrency()
    }
    
    //MARK: - Actions
    
    @objc
    func didtapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func reload() {
        currenciesCollection.reloadData()
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
        navigationController?.navigationBar.tintColor = .ypBlack
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
        presenter?.currenciesArray.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: PayViewControllerCell = currenciesCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PayViewControllerCell else { return UICollectionViewCell()}
        
        if let model = presenter?.currenciesArray[indexPath.row] {
            cell.configureCell(with: model)
        }
        
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PayViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: PayViewControllerCell = collectionView.cellForItem(at: indexPath) as! PayViewControllerCell
        
        guard let currencyID = cell.currencyModel?.id else { return }

        presenter?.selectCurrency(with: currencyID)
        cell.select()
        payView.enablePayButton()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell: PayViewControllerCell = collectionView.cellForItem(at: indexPath) as! PayViewControllerCell
        cell.deselect()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let availableSpace = collectionView.frame.width - (16 + 16 + CGFloat(2 - 1) * 8)
        let cellWidth = availableSpace / 2
        return CGSize(width: cellWidth, height: 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: 0,
            left: 16,
            bottom: 0,
            right: 16
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        8
    }
    
}

// MARK: - PayViewDelegate

extension PayViewController: PayViewDelegate {
    func didTapPayButton() {
        presenter?.performPayment()
    }
    
    func didTapUserAgreementLink() {
        let userAgreementViewController = UserAgreementViewController()
        navigationController?.pushViewController(userAgreementViewController, animated: true)
    }
    
    func switchSuccessViewController() {
        let resultContorller = ResultViewController()
        resultContorller.isSuccess = true
        navigationController?.pushViewController(resultContorller, animated: true)
    }
    
    func switchFailureViewController() {
        let resultContorller = ResultViewController()
        resultContorller.isSuccess = false
        navigationController?.pushViewController(resultContorller, animated: true)
    }
}
