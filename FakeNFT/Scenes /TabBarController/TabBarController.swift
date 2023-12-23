import UIKit

class TabBarController: UITabBarController {

    let appConfiguration: AppConfiguration

    init(appConfiguration: AppConfiguration) {
        self.appConfiguration = appConfiguration
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.appConfiguration = AppConfiguration()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let profileNavigationController = UINavigationController(
            rootViewController: appConfiguration.profileViewController)
        profileNavigationController.tabBarItem = UITabBarItem(
            title: TextLabels.TabBarController.profileTabBarTitle,
            image: UIImage(systemName: "person.crop.circle.fill"),
            selectedImage: nil
        )

        appConfiguration.catalogViewController.tabBarItem = UITabBarItem(
            title: TextLabels.TabBarController.catalogTabBarTitle,
            image: UIImage(systemName: "rectangle.stack.fill"),
            selectedImage: nil
        )
        appConfiguration.cartViewController.tabBarItem = UITabBarItem(
            title: TextLabels.TabBarController.cartTabBarTitle,
            image: UIImage(systemName: "bag.fill"),
            selectedImage: nil
        )
        appConfiguration.statisticViewController.tabBarItem = UITabBarItem(
            title: TextLabels.TabBarController.statisticTabBarTitle,
            image: UIImage(systemName: "flag.2.crossed.fill"),
            selectedImage: nil
        )

        self.viewControllers = [
            profileNavigationController,
            appConfiguration.catalogViewController,
            appConfiguration.cartViewController,
            appConfiguration.statisticViewController
        ]

        tabBar.isTranslucent = false
        view.tintColor = .systemBlue
        tabBar.backgroundColor = .white

        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
