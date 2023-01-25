//
//  TabBarViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 17.06.2022.
//

import Foundation
import UIKit

open class BaseTabBarController: UITabBarController {

    let blueColor = UIColor(red: 24, green: 146, blue: 250)

    public init() {
        super.init(nibName: nil, bundle: nil)
        prepareViewControllers()

    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func prepareViewControllers(){
    
        self.viewControllers = [
            prepareViewController(title: "Dashboard", imageName: "house",
                                  viewController: DashboardViewController()),
            prepareViewController(title: "Patients", imageName: "figure.roll",
                                  viewController: PatientViewController()),
            prepareViewController(title: "Drugs", imageName: "pills",
                                  viewController: DrugsViewController()),
            prepareViewController(title: "Profile", imageName: "person.crop.circle.badge",
                                  viewController: UserProfileViewController())
            
        ]}

    open func prepareViewController(title: String?, imageName: String?, viewController: UIViewController) -> UINavigationController {
        viewController.tabBarItem = prepareTabBarItem(title: title, imageName: imageName)
        UITabBar.appearance().tintColor = .black
        UITabBar.appearance().backgroundColor = .white
        return UINavigationController(rootViewController: viewController)
    }

    open func prepareTabBarItem(title: String?, imageName: String?) -> UITabBarItem {
        let tabBarItem = UITabBarItem()
        tabBarItem.title = title
        tabBarItem.image = UIImage(systemName: imageName ?? "")
        return tabBarItem
    }
}

