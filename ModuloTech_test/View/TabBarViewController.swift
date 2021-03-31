//
//  TabBarViewController.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 29/03/2021.
//

import UIKit

class TabBarViewController: UITabBarController  {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let devicesListViewController = UINavigationController(rootViewController: DevicesListViewController(viewModel: DevicesListViewModel()))
        devicesListViewController.tabBarItem = UITabBarItem(title: "Devices".localized, image: UIImage(named: "device"), tag: 0)
        let userViewController = UINavigationController(rootViewController: UserViewController(viewModel: UserViewModel()))
        userViewController.tabBarItem = UITabBarItem(title: "User".localized, image: UIImage(named: "user"), tag: 1)
        
        self.viewControllers = [devicesListViewController, userViewController]
    }
    

  

}
