//
//  TabBarViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 17.06.2022.
//

import Foundation
import UIKit

open class BaseTabBarController: UITabBarController {

    let mainGreenColor = UIColor(red: 129, green: 199, blue: 132)


    public init() {
        super.init(nibName: nil, bundle: nil)
        prepareViewControllers()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Function sets view controllers to this UITabBarController
    open func prepareViewControllers() {
            self.viewControllers = [
                prepareViewController(title: "Nástěnka", imageName: "house",
                                      viewController: DashboardViewController()),
                prepareViewController(title: "Pacienti", imageName: "figure.roll",
                                      viewController: PatientViewController()),
                prepareViewController(title: "Léky", imageName: "pills",
                                      viewController: DrugsViewController())]
    }

    // MARK: - Sets tabBarItem to view controller and creates UINavigtaionController
    open func prepareViewController(title: String?, imageName: String?, viewController: UIViewController) -> UINavigationController {
        viewController.tabBarItem = prepareTabBarItem(title: title, imageName: imageName)
        //UITabBar.appearance().barTintColor = .orange
        UITabBar.appearance().tintColor = .black
        //UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().backgroundColor = .systemGray6

        return UINavigationController(rootViewController: viewController)
    }

    // MARK - Creates bottom tab bar item
    open func prepareTabBarItem(title: String?, imageName: String?) -> UITabBarItem {
        let tabBarItem = UITabBarItem()
        tabBarItem.title = title
        // MARK - Image is taken from SF Symbols
        tabBarItem.image = UIImage(systemName: imageName ?? "")

        return tabBarItem
    }
}

