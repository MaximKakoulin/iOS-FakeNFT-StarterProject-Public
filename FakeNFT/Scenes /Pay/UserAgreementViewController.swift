//
//  UserAgreementViewController.swift
//  FakeNFT
//
//  Created by Мурад Манапов on 02.01.2024.
//

import UIKit
import WebKit

final class UserAgreementViewController: UIViewController {
    //MARK: private properties
    private let webView = WKWebView()
    private lazy var backButton = UIBarButtonItem(
        image: UIImage.Icons.backward,
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
    //MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        loadPage()
    }
    
    //MARK: - action
    
    @objc
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - Private func
    
    private func loadPage() {
        let request = URLRequest(url: Constants.userAgreementUrl)
        webView.load(request)
    }
    
    private func addView() {
        view.backgroundColor = .ypWhite
        [webView].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        setNavBar()
        addConstraints()
    }
    
    private func setNavBar() {
        navigationController?.navigationBar.barTintColor = .ypWhite
        navigationItem.leftBarButtonItem = backButton
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UIGestureRecognizerDelegate

extension UserAgreementViewController: UIGestureRecognizerDelegate {}
