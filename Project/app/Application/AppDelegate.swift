//
//  AppDelegate.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	private var loginCoord: LoginCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		if #available(iOS 13.0, *) {
			return true
		} else {
			let navigationController = UINavigationController()
			loginCoord = LoginCoordinator(presenter: navigationController)

			window = UIWindow(frame: UIScreen.main.bounds)
			window?.backgroundColor = .white
			window?.rootViewController = navigationController
			window?.makeKeyAndVisible()
			loginCoord?.start()
			return true
		}
    }
}
