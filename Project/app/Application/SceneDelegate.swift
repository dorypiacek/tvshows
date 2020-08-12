//
//  SceneDelegate.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 12/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
	private var loginCoord: LoginCoordinator?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard scene as? UIWindowScene != nil else {
			return
		}
        if let windowScene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: windowScene)
			window?.backgroundColor = .white
            let navigationController = UINavigationController()
			loginCoord = LoginCoordinator(presenter: navigationController)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
			loginCoord?.start()
        }
    }
}
