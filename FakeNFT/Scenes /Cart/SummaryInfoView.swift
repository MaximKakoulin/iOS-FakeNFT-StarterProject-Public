//
//  SummaryInfoView.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 18.12.2023.
//

import UIKit


final class SummaryInfoView: UIView {
    private var countNftLabel: UILabel = {
        let count = UILabel()
        count.translatesAutoresizingMaskIntoConstraints = false
        count.font = .caption15
        count.textColor = .ypBlack
        count.text = "0 NFT"
        return count
    }()
    
    private var priceLabel: UILabel = {
        let price = UILabel()
        price.translatesAutoresizingMaskIntoConstraints = false
        price.font = .bodyBold17
        price.textColor = .ypGreen
        price.text = "O BTC"
        return price
    }()
    
    private var labelStack: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .vertical
        element.spacing = 2
        return element
    }()
    
    private var toPayButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.backgroundColor = .ypBlack
        button.setTitleColor(.ypWhite, for: .normal)
        button.setTitle("To pay", for: .normal)
        button.titleLabel?.font = .bodyBold17
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .ypLightGray
        layer.cornerRadius = 12
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureSummary(with summaryInfo: SummaryInfo) {
        countNftLabel.text = "\(summaryInfo.countNFT) NFT"
        priceLabel.text = "\(summaryInfo.price) ETH"
    }
    
    private func addViews() {
        addSubview(toPayButton)
        addSubview(labelStack)
        
        labelStack.addArrangedSubview(countNftLabel)
        labelStack.addArrangedSubview(priceLabel)
        
        addConstraints()
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            labelStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            labelStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            labelStack.trailingAnchor.constraint(equalTo: toPayButton.leadingAnchor, constant: 24),
            labelStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            toPayButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            toPayButton.leadingAnchor.constraint(equalTo: labelStack.trailingAnchor, constant: 24),
            toPayButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            toPayButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            toPayButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
