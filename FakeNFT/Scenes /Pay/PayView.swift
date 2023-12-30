//
//  PayView.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 30.12.2023.
//

import UIKit

protocol PayViewDelegate: AnyObject {
    func didTapPayButton()
    func didTapUserAgreementLink()
}

final class PayView: UIView, UITextViewDelegate {
    
    //MARK: - Properties
    private lazy var userAgreementTextView: UITextView = {
        let textView = UITextView()
        textView.font = .caption13
        textView.textColor = .ypBlack
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        let fullText = NSLocalizedString(
            "Agree purchase", comment: ""
        ) + " " + NSLocalizedString(
            "User Agreement", comment: ""
        )
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let agreementRange = (
            fullText as NSString).range(of: NSLocalizedString("User Agreement", comment: "")
            )
        
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.ypBlue!,
            range: agreementRange
        )
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length)
        )
        textView.addGestureRecognizer(
            UITapGestureRecognizer(target: self,
                                   action: #selector(didTapUserAgreementLink))
        )
        
        textView.attributedText = attributedString
        textView.isUserInteractionEnabled = true
        textView.delegate = self
        
        return textView
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.backgroundColor = .ypBlack
        button.setTitleColor(.ypWhite, for: .normal)
        let text = NSLocalizedString("Pay", comment: "")
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = .bodyBold17
        button.isEnabled = false
        button.addTarget(
            self,
            action: #selector(didTapPayButton), for: .touchUpInside
        )
        return button
    }()
    
    // MARK: - Properties
    weak var delegate: PayViewDelegate?
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapPayButton() {
        delegate?.didTapPayButton()
    }
    
    @objc
    private func didTapUserAgreementLink(sender: UIGestureRecognizer) {
        delegate?.didTapUserAgreementLink()
    }
    
    // MARK: - Methods
    
    func enablePayButton() {
        payButton.isEnabled = true
    }
    
    // MARK: - Private methods
    
    private func addView() {
        backgroundColor = .ypLightGray
        layer.cornerRadius = 12
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        [payButton, userAgreementTextView].forEach {
            addSubview($0)
        }
        
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            payButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            payButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            payButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            payButton.heightAnchor.constraint(equalToConstant: 60),
            
            userAgreementTextView.leadingAnchor.constraint(equalTo: payButton.leadingAnchor),
            userAgreementTextView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            userAgreementTextView.trailingAnchor.constraint(equalTo: payButton.trailingAnchor),
            userAgreementTextView.bottomAnchor.constraint(equalTo: payButton.topAnchor, constant: -16)
        ])
    }
}
