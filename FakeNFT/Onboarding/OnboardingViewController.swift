//
//  OnboardingViewController.swift
//  FakeNFT
//
//  Created by Максим on 27.12.2023.
//

import UIKit

final class OnboardingViewController: UIPageViewController {

    private let appConfiguration = AppConfiguration()
    private var pages: [UIViewController] = []
    private var currentPageIndex = 0

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0

        if #available(iOS 14.0, *) {
            pageControl.preferredIndicatorImage = UIImage(named: "PaginationNoActive")
        } else {
            pageControl.pageIndicatorTintColor = UIColor.lightGray
            pageControl.currentPageIndicatorTintColor = UIColor.black
        }
        if #available(iOS 16.0, *) {
            pageControl.preferredCurrentPageIndicatorImage = UIImage(named: "PaginationActive")
        } else {
        }

        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .whiteUni
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(TextLabels.OnboardingVC.onboardingButton, for: .normal)
        button.backgroundColor = .blackUni
        button.layer.cornerRadius = 16
        button.setTitleColor(.whiteUni, for: .normal)
        button.titleLabel?.font = .bodyBold17
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey: Any]? = nil
    ) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        let page1 = createOnboardingPage(imageName: "OnboardingImage1",
                                         labelText: TextLabels.OnboardingVC.firstHeader,
                                         descriptionText: TextLabels.OnboardingVC.firstDescription)
        let page2 = createOnboardingPage(imageName: "OnboardingImage2",
                                         labelText: TextLabels.OnboardingVC.secondHeader,
                                         descriptionText: TextLabels.OnboardingVC.secondDescription)
        let page3 = createOnboardingPage(imageName: "OnboardingImage3",
                                         labelText: TextLabels.OnboardingVC.thirdHeader,
                                         descriptionText: TextLabels.OnboardingVC.thirdDescription)

        pages.append(page1)
        pages.append(page2)
        pages.append(page3)

        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
            button.isHidden = true
        }

        view.addSubview(pageControl)
        view.addSubview(button)
        view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalToConstant: 24),

            pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -66),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    @objc private func buttonTapped() {
        let tabBarController = TabBarController(appConfiguration: appConfiguration)
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        window.rootViewController = tabBarController
    }

    @objc private func closeButtonTapped() {
            let tabBarController = TabBarController(appConfiguration: appConfiguration)
            guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }

    func createOnboardingPage(imageName: String, labelText: String, descriptionText: String) -> UIViewController {
        let onboardingVC = UIViewController()

        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        onboardingVC.view.addSubview(imageView)

        let label = UILabel()
        label.text = labelText
        label.textColor = .whiteUni
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        onboardingVC.view.addSubview(label)

        let description = UILabel()
        description.text = descriptionText
        description.numberOfLines = 2
        description.textColor = .whiteUni
        description.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        description.textAlignment = .left
        description.translatesAutoresizingMaskIntoConstraints = false
        onboardingVC.view.addSubview(description)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: onboardingVC.view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: onboardingVC.view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: onboardingVC.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: onboardingVC.view.trailingAnchor),

            label.topAnchor.constraint(equalTo: onboardingVC.view.topAnchor, constant: 230),
            label.leadingAnchor.constraint(equalTo: onboardingVC.view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: onboardingVC.view.trailingAnchor, constant: -16),

            description.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12),
            description.leadingAnchor.constraint(equalTo: onboardingVC.view.leadingAnchor, constant: 16),
            description.trailingAnchor.constraint(equalTo: onboardingVC.view.trailingAnchor, constant: -16)
        ])

        return onboardingVC
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return nil
        }

        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1

        guard nextIndex < pages.count else {
            return nil
        }

        return pages[nextIndex]
    }
}

// MARK: - UIPageViewControllerDelegate
extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        if let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            pageControl.currentPage = currentIndex

            currentPageIndex = currentIndex
            button.isHidden = currentIndex != 2
        }
    }
}
