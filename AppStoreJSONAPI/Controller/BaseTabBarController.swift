//
//  BaseTabBarController.swift
//  AppStoreJSONAPI
//
//  Created by Sean on 2020/4/2.
//  Copyright © 2020 Sean. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        viewControllers = [
            createNavController(vc: AppsPageController(), title: "Apps", imageName: "apps"),
            createNavController(vc: AppsSearchController(), title: "Search", imageName: "search"),
            createNavController(vc: ViewController(), title: "Today", imageName: "today_icon"),
        ]
    }
    
    fileprivate func createNavController(vc: UIViewController, title: String, imageName: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        vc.navigationItem.title = title
        vc.view.backgroundColor = .white
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
}
