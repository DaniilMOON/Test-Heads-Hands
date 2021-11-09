// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Asset.fieldBackground.color
        view.addSubview(profileView)
        profileView.safeArea { $0.top().left().right() }

        authService?.getProfile(completion: { (result: Result<Profile, Error>) in
            switch result {
            case let .success(pr):
                self.profile = pr
                self.profileView.fillWith(profile: self.profile)
            case let .failure(error):
                print(error)
            }
        })

        setupBtn()
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

    private lazy var myOrderButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(myOrderBtn(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(settingBtn(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logoutPressed(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var icon1: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private lazy var label1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var icon2: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private lazy var label2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var icon3: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private lazy var label3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func setupBtn() {
        view.addSubview(myOrderButton)
        view.addSubview(settingsButton)
        view.addSubview(logoutButton)

        myOrderButton
            .top(to: .bottom(24), of: profileView)
            .left(16)
            .height((view.frame.width - 16 * 4) / 3)
            .width((view.frame.width - 16 * 4) / 3)
        myOrderButton.backgroundColor = Asset.white.color
        myOrderButton.layer.cornerRadius = 16

        myOrderButton.addSubview(icon1)
        icon1.centerX().centerY(-9).height(24).width(24)
        icon1.image = Asset.myOrder.image

        myOrderButton.addSubview(label1)
        label1.centerX().centerY(14)
        label1.font = UIFont(name: "Roboto-Medium", size: 12)
        label1.text = L10n.Profile.myOrder

        settingsButton
            .top(to: .bottom(24), of: profileView)
            .centerX()
            .height((view.frame.width - 16 * 4) / 3)
            .width((view.frame.width - 16 * 4) / 3)
        settingsButton.backgroundColor = Asset.white.color
        settingsButton.layer.cornerRadius = 16

        settingsButton.addSubview(icon2)
        icon2.centerX().centerY(-9).height(24).width(24)
        icon2.image = Asset.settings.image

        settingsButton.addSubview(label2)
        label2.centerX().centerY(14)
        label2.font = UIFont(name: "Roboto-Medium", size: 12)
        label2.text = L10n.Profile.settings

        logoutButton
            .top(to: .bottom(24), of: profileView)
            .right(16)
            .height((view.frame.width - 16 * 4) / 3)
            .width((view.frame.width - 16 * 4) / 3)
        logoutButton.backgroundColor = Asset.logoutButton.color
        logoutButton.layer.cornerRadius = 16

        logoutButton.addSubview(icon3)
        icon3.centerX().centerY(-9).height(24).width(24)
        icon3.image = Asset.logout.image

        logoutButton.addSubview(label3)
        label3.centerX().centerY(14)
        label3.font = UIFont(name: "Roboto-Medium", size: 12)
        label3.textColor = Asset.white.color
        label3.text = L10n.Profile.logout
    }

    @objc
    private func logoutPressed(_: Any) {
        let alert = UIAlertController(title: L10n.Profile.Alert.question, message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: L10n.Profile.Alert.exit, style: .default) { _ in
            self.dataService?.appState.accessToken = nil
            UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = VCFactory.buildAuthVC()
        })
        alert.addAction(UIAlertAction(title: L10n.Profile.Alert.cancel, style: .cancel, handler: nil))

        present(alert, animated: true)
    }

    @objc
    private func settingBtn(_: Any) {}

    @objc
    private func myOrderBtn(_: Any) {}
}
