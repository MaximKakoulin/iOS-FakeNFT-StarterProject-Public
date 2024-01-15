//
//  DeleteFromCartViewController.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 16.12.2023.
//

import UIKit
import Kingfisher


protocol DeleteFromCartViewControllerDelegate: AnyObject {
    func didTapReturnButton()
    func didTapDeleteButton(_ model: NFTModelCart)
}

final class DeleteFromCartViewController: UIViewController {
    // MARK: - Properties
    
    var nftForDelete: NFTModelCart?
    weak var delegate: DeleteFromCartViewControllerDelegate?
    
    
    //MARK: - private properties
    
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    private let nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .ypBlack
        label.font = .caption13
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = NSLocalizedString("NFT Delete", comment: "")
        return label
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var deleteButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .ypBlack
        let text = NSLocalizedString("Delete", comment: "")
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = .bodyRegular17
        button.setTitleColor(.ypRed, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var returnButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .ypBlack
        let text = NSLocalizedString("Return", comment: "")
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = .bodyRegular17
        button.setTitleColor(.ypWhite, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapReturnButton), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapReturnButton() {
        delegate?.didTapReturnButton()
    }
    
    @objc
    private func didTapDeleteButton() {
        guard let nftForDelete else { return }
        delegate?.didTapDeleteButton(nftForDelete)
    }
    
    
    //MARK: - Private Methods
    
    private func addViews() {
        [blurView, titleLabel, buttonsStackView, nftImageView]
            .forEach{
                view.addSubview($0)
            }
        
        guard
            let image = nftForDelete?.images.first,
            let urlImage = URL(string: image)
        else { return }
        nftImageView.kf.setImage(with: urlImage)
        
        buttonsStackView.addArrangedSubview(deleteButton)
        buttonsStackView.addArrangedSubview(returnButton)
        
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 180),
            
            nftImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -12),
            nftImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),
            
            buttonsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            buttonsStackView.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            buttonsStackView.widthAnchor.constraint(equalToConstant: 262),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}




