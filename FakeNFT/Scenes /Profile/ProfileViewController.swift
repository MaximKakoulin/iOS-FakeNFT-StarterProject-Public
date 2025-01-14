//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Максим on 17.12.2023.
//

import UIKit
import Kingfisher
import SafariServices

protocol ProfileViewProtocol: AnyObject {
    func updateUI(with profile: UserProfile)
    func displayError(_ error: Error)
    func navigateToEditProfileScreen()
}

final class ProfileViewController: UIViewController {
    // MARK: - Private Properties
    private var presenter: ProfilePresenterProtocol?
    private var userProfileStackView: UserProfileStackView!
    private var profileButtonsStackView: ProfileButtonsStackView!

    private var currentAvatarImage: UIImage?

    init(presenter: ProfilePresenterProtocol?) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidLoad()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteDayNight
        (self.presenter as? ProfilePresenter)?.delegate = self
        setupNavigationBar()
        setupViews()
    }

    private func setupNavigationBar() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let image = UIImage(systemName: "square.and.pencil", withConfiguration: configuration)
        let barButtonItem = UIBarButtonItem(image: image,
                                            style: .plain,
                                            target: self,
                                            action: #selector(rightButtonTapped))
        barButtonItem.tintColor = .blackDayNight
        navigationItem.rightBarButtonItem = barButtonItem
    }

    private func setupViews() {
        userProfileStackView = UserProfileStackView()
        profileButtonsStackView = ProfileButtonsStackView()
        userProfileStackView.delegate = self
        profileButtonsStackView.delegate = self

        view.addSubview(userProfileStackView)
        view.addSubview(profileButtonsStackView)

        userProfileStackView.translatesAutoresizingMaskIntoConstraints = false
        profileButtonsStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            userProfileStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userProfileStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userProfileStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            profileButtonsStackView.topAnchor.constraint(equalTo: userProfileStackView.bottomAnchor, constant: 40),
            profileButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileButtonsStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                            constant: -20)
        ])
    }

    @objc func rightButtonTapped() {
        navigateToEditProfileScreen()
    }
}

// MARK: - ProfileViewProtocol
extension ProfileViewController: ProfileViewProtocol {

    func updateUI(with profile: UserProfile) {
        userProfileStackView.update(with: profile)
        userProfileStackView.onImageLoaded = { [weak self] image in
            guard self?.currentAvatarImage != image else { return }
            self?.currentAvatarImage = image
        }
        profileButtonsStackView.update(with: profile)
    }

    func displayError(_ error: Error) {

    }

    func navigateToEditProfileScreen() {
        let profileService = ProfileService()
        let editProfileVC = ProfileEditViewController(presenter: nil, image: currentAvatarImage)
        editProfileVC.delegate = self
        let editProfilePresenter = ProfileEditPresenter(view: editProfileVC, profileService: profileService)
        editProfilePresenter.delegate = self
        editProfileVC.presenter = editProfilePresenter
        editProfileVC.currentUserProfile = self.presenter?.currentUserProfile
        editProfileVC.modalPresentationStyle = .pageSheet
        present(editProfileVC, animated: true, completion: nil)
    }

    func navigateToAboutDeveloperScreen() {
        let aboutDeveloperVC = AboutDeveloperViewController()
        self.navigationController?.pushViewController(aboutDeveloperVC, animated: true)
    }
}

extension ProfileViewController: ProfileEditPresenterDelegate {
    func profileDidUpdate(_ profile: UserProfile) {
        self.updateUI(with: profile)
        self.presenter?.updateCurrentUserProfile(with: profile)
    }
}

extension ProfileViewController: ProfileEditViewControllerDelegate {
    func didUpdateAvatar(_ newAvatar: UIImage) {
        self.userProfileStackView.updateAvatarImage(newAvatar)
        let cache = ImageCache.default
        cache.store(newAvatar, forKey: "userAvatarImage")
        self.currentAvatarImage = newAvatar
    }
}

extension ProfileViewController: UserProfileStackViewDelegate {
    func userProfileStackViewDidTapWebsite(_ stackView: UserProfileStackView, url: URL) {
        let safaryVC = SFSafariViewController(url: url)
        self.present(safaryVC, animated: true, completion: nil)
    }
}

extension ProfileViewController: ProfileButtonsStackViewDelegate {
    func didTapMyNFTButton() {
        presenter?.didTapMyNFTs()
    }

    func didTapFavoritesNFTButton() {
        presenter?.didTapFavorites()
    }

    func didTapAboutDeveloperButton() {
        navigateToAboutDeveloperScreen()
    }

}

extension ProfileViewController: ProfilePresenterDelegate {
    func shouldNavigateToMyNFTsScreen(with ids: [String], and likedIds: [String]) {
        let myNFTsVC = MyNFTsViewController(nftIds: ids, likedNFTIds: likedIds)
        myNFTsVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(myNFTsVC, animated: true)
    }

    func shouldNavigateTofavoriteNFTsScreen(with likedIds: [String]) {
        let favoriteNFTsVC = FavoritesNFTViewController(likedNFTIds: likedIds)
        favoriteNFTsVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(favoriteNFTsVC, animated: true)
    }

}
