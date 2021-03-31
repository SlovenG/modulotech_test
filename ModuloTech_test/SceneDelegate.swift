//
//  SceneDelegate.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 25/03/2021.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
    }

  

}

