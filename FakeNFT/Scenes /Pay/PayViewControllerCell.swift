//
//  PayViewControllerCell.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 28.12.2023.
//

import UIKit
import Kingfisher

final class PayViewControllerCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var currencyModel: CurrencyModel?
    
    
    // MARK: - Provate properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let imageBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 6
        view.backgroundColor = .ypBlack
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .caption13
        label.textColor = .ypGreen
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .caption13
        return label
    }()
    
    private let labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    
    //MARK: - view lifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        deselect()
    }
    
    
    // MARK: - Methods
    func configureCell(with model: CurrencyModel) {
        currencyModel = model
        
        let imageUrl = URL(string: model.image)
        imageView.kf.setImage(with: imageUrl)
        titleLabel.text = model.title
        nameLabel.text = model.name
    }
    
    func select() {
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
    }
    
    func deselect() {
        contentView.layer.borderWidth = 0
    }
    
    func addView() {
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .ypLightGray
        
        [imageBackgroundView, imageView, labelsStackView].forEach {
            contentView.addSubview($0)
        }
        
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(nameLabel)
        
        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            imageBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            imageBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            imageBackgroundView.widthAnchor.constraint(equalToConstant: 36),
            imageBackgroundView.heightAnchor.constraint(equalToConstant: 36),
            
            imageView.centerXAnchor.constraint(equalTo: imageBackgroundView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageBackgroundView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 31.5),
            imageView.heightAnchor.constraint(equalToConstant: 31.5),
            
            labelsStackView.centerYAnchor.constraint(equalTo: imageBackgroundView.centerYAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor, constant: 4)
        ])
    }
    
    
}
