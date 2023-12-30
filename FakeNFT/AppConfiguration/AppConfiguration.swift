//
//  AppConfiguration.swift
//  FakeNFT
//
//  Created by Максим on 17.12.2023.
//

import UIKit

class AppConfiguration {
    let profileViewController: UIViewController
    let catalogViewController: UIViewController
    let cartViewController: UIViewController
    let statisticViewController: UIViewController

    init() {
        // MARK: - Эпик Профиля
        let networkClient = DefaultNetworkClient()
        let profileService = ProfileService(networkClient: networkClient)
        let profilePresenter = ProfilePresenter(view: nil,
                                                profileService: profileService)
        profileViewController = ProfileViewController(presenter: profilePresenter)
        profilePresenter.view = profileViewController as? ProfileViewProtocol

        catalogViewController = UIViewController()
        cartViewController = UIViewController()
        statisticViewController = UIViewController()
    }
}
