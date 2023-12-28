//
//  Strings.swift
//  FakeNFT
//
//  Created by Максим on 23.12.2023.
//

import Foundation

struct TextLabels {
    struct TabBarController {
        static var profileTabBarTitle: String {
            return NSLocalizedString("profileTabBarTitle", comment: "")
        }
        static var catalogTabBarTitle: String {
            return NSLocalizedString("catalogTabBarTitle", comment: "")
        }
        static var cartTabBarTitle: String {
            return NSLocalizedString("cartTabBarTitle", comment: "")
        }
        static var statisticTabBarTitle: String {
            return NSLocalizedString("statisticTabBarTitle", comment: "")
        }
    }

    struct ProfileEditVC {
        static var avatarLabel: String {
            return NSLocalizedString("avatarLabel", comment: "")
        }
        static var nameStackViewLabel: String {
            return NSLocalizedString("nameStackViewLabel", comment: "")
        }
        static var nameStackViewContent: String {
            return NSLocalizedString("nameStackViewContent", comment: "")
        }
        static var descriptionStackViewLabel: String {
            return NSLocalizedString("descriptionStackViewLabel", comment: "")
        }
        static var descriptionStackViewContent: String {
            return NSLocalizedString("descriptionStackViewContent", comment: "")
        }
        static var websiteStackViewLabel: String {
            return NSLocalizedString("websiteStackViewLabel", comment: "")
        }
        static var websiteStackViewContent: String {
            return NSLocalizedString("websiteStackViewContent", comment: "")
        }
        static var profileUpdatedSuccesfully: String {
            return NSLocalizedString("profileUpdatedSuccessfully", comment: "")
        }
        static var saveButton: String {
            return NSLocalizedString("saveButton", comment: "")
        }
    }

    struct ProfileEditStackView {
        static var keyboardDoneButton: String {
            return NSLocalizedString("keyboardDoneButton", comment: "")
        }
        static var keyboardResetButton: String {
            return NSLocalizedString("keyboardResetButton", comment: "")
        }
    }

    struct ProfileButtonsStackView {
        static var myNFTLabel: String {
            return NSLocalizedString("myNFTLabel", comment: "")
        }
        static var favoritesNFTLabel: String {
            return NSLocalizedString("favoritesNFTLabel", comment: "")
        }
        static var aboutDeveloperLabel: String {
            return NSLocalizedString("aboutDeveloperLabel", comment: "")
        }
    }

    struct UserProfileStackView {
        static var userNameLabel: String {
            return NSLocalizedString("userNameLabel", comment: "")
        }
        static var userInfoLabel: String {
            return NSLocalizedString("userInfoLabel", comment: "")
        }
        static var websiteLabel: String {
            return NSLocalizedString("websiteLabel", comment: "")
        }
    }

    struct MyNFTsVC {
        static var navigationTitle: String {
            return NSLocalizedString("myNFTsNavigationTitle", comment: "")
        }
        static var cellNFTPriceLabel: String {
            return NSLocalizedString("cellNFTPriceLabel", comment: "")
        }
        static var alertTitleLabel: String {
            return NSLocalizedString("alertTitleLabel", comment: "")
        }
        static var alertPriceLabel: String {
            return NSLocalizedString("alertPriceLabel", comment: "")
        }
        static var alertRatingLabel: String {
            return NSLocalizedString("alertRatingLabel", comment: "")
        }
        static var alertNameLabel: String {
            return NSLocalizedString("alertNameLabel", comment: "")
        }
        static var alertCloseLabel: String {
            return NSLocalizedString("alertCloseLabel", comment: "")
        }
        static var placeholder: String {
            return NSLocalizedString("myNFTsPlaceholder", comment: "")
        }
        static var wordFrom: String {
            return NSLocalizedString("wordFrom", comment: "")
        }
    }

    struct FavoritesNFTsVC {
        static var navigationTitle: String {
            return NSLocalizedString("favoritesNFTsNavigationTitle", comment: "")
        }
        static var placeholder: String {
            return NSLocalizedString("favoritesNFTsPlaceholder", comment: "")
        }
    }

    struct AboutDevelopersVC {
        static var navigationTitle: String {
            return NSLocalizedString("aboutDevelopersNavigationTitle", comment: "")
        }
    }

    struct OnboardingVC {
        static var firstHeader: String {
            return NSLocalizedString("firstHeader", comment: "")
        }
        static var firstDescription: String {
            return NSLocalizedString("firstDescription", comment: "")
        }
        static var secondHeader: String {
            return NSLocalizedString("secondHeader", comment: "")
        }
        static var secondDescription: String {
            return NSLocalizedString("secondDescription", comment: "")
        }
        static var thirdHeader: String {
            return NSLocalizedString("thirdHeader", comment: "")
        }
        static var thirdDescription: String {
            return NSLocalizedString("thirdDescription", comment: "")
        }
        static var onboardingButton: String {
            return NSLocalizedString("onboardingButton", comment: "")
        }
    }
}
