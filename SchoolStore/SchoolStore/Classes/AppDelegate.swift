// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: Internal

    var window: UIWindow?

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let initialVC: UIViewController? = dataService.appState.isUserAuthenticated ? VCFactory.buildTabBarVC() : VCFactory.buildAuthVC()

        window?.rootViewController = initialVC
        window?.makeKeyAndVisible()

        UINavigationBar.appearance().barTintColor = Asset.main.color
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = Asset.white.color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: Asset.white.color]

        return true
    }

    // MARK: Private

    private let dataService: DataService = CoreFactory.dataService
}
