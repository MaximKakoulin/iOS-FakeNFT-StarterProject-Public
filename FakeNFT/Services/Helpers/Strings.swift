//
//  Strings.swift
//  FakeNFT
//
//  Created by Максим on 23.12.2023.
//

import Foundation

struct TextLabels {
    struct TabBarController {
        static let profileTabBarTitle = "Профиль"
        static let catalogTabBarTitle = "Каталог"
        static let cartTabBarTitle = "Корзина"
        static let statisticTabBarTitle = "Статистика"
    }

    struct ProfileEditVC {
        static let avatarLabel: String = "Cменить\nфото"
        static let nameStackViewLabel: String = "Имя"
        static let nameStackViewContent: String = "Введите Ваше имя"
        static let descriptionStackViewLabel: String = "Описание"
        static let descriptionStackViewContent: String = "Введите Ваше описание"
        static let websiteStackViewLabel: String = "Сайт"
        static let websiteStackViewContent: String = "Введите Ваш Сайт"
        static let profileUpdatedSuccessfully: String = "Профиль успешно обновлен"
        static let saveButton: String = "Сохранить"
    }

    struct ProfileEditStackView {
        static let keyboardDoneButton: String = "Готово"
        static let keyboardResetButton: String = "Отменить ввод"
    }

    struct ProfileButtonsStackView {
        static let myNFTLabel: String = "Мои NFT"
        static let favoritesNFTLabel: String = "Избранные NFT"
        static let aboutDeveloperLabel: String = "О разработчике"
    }

    struct UserProfileStackView {
        static let userNameLabel: String = "Имя Пользователя"
        static let userInfoLabel: String = "Информация о Вас. Здесь может быть ваши данные или другую информацию."
        static let websiteLabel: String = "www.internet.com"
    }
}