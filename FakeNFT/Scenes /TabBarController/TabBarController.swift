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
        UITabBar.appearance().barTintColor = .systemBackground
        view.backgroundColor = .systemBackground
        
        setupTabBarItems()
    }
    
    private func setupTabBarItems() {
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
        
        let cartViewController = UINavigationController(
            rootViewController: appConfiguration.cartViewController)
        cartViewController.tabBarItem = UITabBarItem(
            title: TextLabels.TabBarController.cartTabBarTitle,
            image: UIImage(systemName: "bag.fill"),
            selectedImage: nil
        )
        cartViewController.navigationBar.prefersLargeTitles = true
        
        appConfiguration.statisticViewController.tabBarItem = UITabBarItem(
            title: TextLabels.TabBarController.statisticTabBarTitle,
            image: UIImage(systemName: "flag.2.crossed.fill"),
            selectedImage: nil
        )

        self.viewControllers = [
            profileNavigationController,
            appConfiguration.catalogViewController,
            cartViewController,
            appConfiguration.statisticViewController
        ]

        tabBar.isTranslucent = false
        view.tintColor = .systemBlue
        tabBar.backgroundColor = .ypRed
        tabBar.unselectedItemTintColor = .ypBlack

        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
