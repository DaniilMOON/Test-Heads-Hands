// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(profileView)
        profileView.safeArea { $0.top().left().right() }

//        authService?.getProfile(completion: { [weak self] (result: Result<String, Error>) in
//            switch result {
//            case .success:
//                UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = VCFactory.buildTabBarVC()
//            case let .failure(error):
//                self?.handle(error: error)
//            }
//        })
    }

    // MARK: Internal

    var dataService: DataService?
    var authService: AuthService?

    var profile: Profile?

    // MARK: Private

    private var profileView: ProfileView = {
        let pv = ProfileView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()

    @objc
    private func logoutPressed(_: Any) {
        dataService?.appState.accessToken = nil
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = VCFactory.buildAuthVC()
    }
}
