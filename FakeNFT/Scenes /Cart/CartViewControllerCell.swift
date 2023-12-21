//
//  CartViewControllerCell.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 16.12.2023.
//

import UIKit
import Kingfisher

protocol CartNFTCellDelegate: AnyObject {
    func didTapDeleteButton(on nft: NFTModel)
}

final class CartViewControllerCell: UITableViewCell {
    
    //MARK: - Properties
    
    weak var delegate: CartNFTCellDelegate?
    private var model: NFTModel?
    
    
    // MARK: - private Properties
    
    private let imageCellView: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let ratingImageView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
       let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .bodyBold17
        title.textColor = .ypBlack
        return title
    }()
    
    private let priceTitle: UILabel = {
       let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .caption13
        title.text = "Цена"
        title.textColor = .ypBlack
        return title
    }()
    
    private lazy var price: UILabel = {
       let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .bodyBold17
        title.textColor = .ypBlack
        return title
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.Icons.deleteFromCart, for: .normal)
        button.addTarget(self, action: #selector(didTapRemoveButton), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Actions
    
    @objc
    private func didTapRemoveButton() {
        guard let model else { return }
        delegate?.didTapDeleteButton(on: model)
    }
    
    
    // MARK: - Public Methods
    
    func configureCell(with model: NFTModel) {
        self.model = model
        guard
            let image = model.images.first,
            let urlImage = URL(string: image)
        else { return }
        imageCellView.kf.setImage(with: urlImage)
        titleLabel.text = model.name
        price.text = "\(model.price) ETH"
        switch model.rating {
            case 0: ratingImageView.image = UIImage.Icons.zeroStarRating
            case 1: ratingImageView.image = UIImage.Icons.oneStarRating
            case 2: ratingImageView.image = UIImage.Icons.twoStarRating
            case 3: ratingImageView.image = UIImage.Icons.threeStarRating
            case 4: ratingImageView.image = UIImage.Icons.fourStarRating
            case 5: ratingImageView.image = UIImage.Icons.fiveStarRating
        default:
            break
        }
    }
    
    
    
    // MARK: - Private Methods
    
    private func setView() {
        [imageCellView, titleLabel, ratingImageView, priceTitle, price, deleteButton]
            .forEach {
                contentView.addSubview($0)
            }

        addConstraints()
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            imageCellView.widthAnchor.constraint(equalToConstant: 108),
            imageCellView.heightAnchor.constraint(equalToConstant: 108),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageCellView.trailingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: imageCellView.topAnchor, constant: 8),
            
            ratingImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            
            priceTitle.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceTitle.bottomAnchor.constraint(equalTo: price.topAnchor, constant: -2),
            
            price.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            price.bottomAnchor.constraint(equalTo: imageCellView.bottomAnchor, constant: -8),
            
            deleteButton.centerYAnchor.constraint(equalTo: imageCellView.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    
}
