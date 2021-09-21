//
//  AppDelegate.swift
//  Homework_2_registration
//
//  Created by Даниил Осипов on 20.09.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootVC: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Main")
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        return true
    }
}

