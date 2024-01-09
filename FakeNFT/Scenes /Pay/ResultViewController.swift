//
//  ResultViewController.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 07.01.2024.
//

import UIKit


final class ResultViewController: UIViewController {
    //MARK: - Properties
    var isSuccess: Bool?
    
    
    //MARK: - Private Properties
    private let imageView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 12
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
       let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .headline22
        title.textColor = .ypBlack
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    
    private lazy var backButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .ypBlack
        button.layer.masksToBounds = true
        button.setTitleColor(.ypWhite, for: .normal)
        button.titleLabel?.font = .bodyBold17
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapReturnButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Actions
    @objc
    private func didTapReturnButton() {
        if isSuccess! {
            navigationController?.popToRootViewController(animated: false)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhite
        addView()
    }
    
    
    //MARK: - Private methods
    private func addView() {
        [stackView, backButton].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        if isSuccess! {
            imageView.image = UIImage.Images.successPayImage
            titleLabel.text = NSLocalizedString("Success! Payment completed, congratulations on your purchase!", comment: "")
            backButton.setTitle("BACK to catalog", for: .normal)
        } else {
            imageView.image = UIImage.Images.failurePayImage
            titleLabel.text = NSLocalizedString("Oops! Something went wrong :( Try again!", comment: "")
            backButton.setTitle(NSLocalizedString("Try again", comment: ""), for: .normal)
        }
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        
        setNavBar()
        addConstraint()
    }
    
    private func setNavBar() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: 278),
            imageView.heightAnchor.constraint(equalToConstant: 278),
            
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            backButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            backButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
