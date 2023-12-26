import UIKit

final class TabBarController: UITabBarController {

    var servicesAssembly: ServicesAssembly!

    private let catalogTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.catalog", comment: ""),
        image: UIImage(systemName: "square.stack.3d.up.fill"),
        tag: 0
    )

    override func viewDidLoad() {
        super.viewDidLoad()

//        let catalogController = TestCatalogViewController(
//            servicesAssembly: servicesAssembly
//        )
//        catalogController.tabBarItem = catalogTabBarItem
//        viewControllers = [catalogController]
        UITabBar.appearance().barTintColor = .systemBackground
        view.backgroundColor = .systemBackground
        setupTabBarItems()
    }
    
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage
    ) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
    
    
    private func setupTabBarItems() {
        viewControllers = [
            createNavController(for: CartViewController(),
                                title: NSLocalizedString("Cart", comment: ""),
                                image: .Icons.cartTab!)
        ]
        tabBar.unselectedItemTintColor = .ypBlack
    }
}
