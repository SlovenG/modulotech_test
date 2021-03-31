//
//  AppCoordinator.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 26/03/2021.
//

import Foundation
import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        let viewController = TabBarViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
    }
}


class DarkModeAwareNavigationController: UINavigationController {

  override init(rootViewController: UIViewController) {
       super.init(rootViewController: rootViewController)
       self.updateBarTintColor()
  }

  required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       self.updateBarTintColor()
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       super.traitCollectionDidChange(previousTraitCollection)
       self.updateBarTintColor()
  }

  private func updateBarTintColor() {
       if #available(iOS 13.0, *) {
            self.navigationBar.barTintColor = UITraitCollection.current.userInterfaceStyle == .dark ? .black : .white
  }
  }
}
