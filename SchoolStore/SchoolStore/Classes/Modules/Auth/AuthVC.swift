// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        localizable()
    }

    // MARK: Internal

    @IBOutlet var loginField: InputField!

    @IBOutlet var passwordField: InputField!

    @IBOutlet var signInButton: UIButton!

    func setup(with authService: AuthService, _ snacker: Snacker) {
        self.authService = authService
        self.snacker = snacker
    }

    @IBAction func signInPressed(_: Any) {
        guard let user = loginField.text, let password = passwordField.text else {
            return
        }
        if user.isEmpty {
            loginField.error = L10n.Common.emptyField
        } else if password.isEmpty {
            passwordField.error = L10n.Common.emptyField
        } else {
            authService?.authenticate(user: user, with: password, completion: { [weak self] (result: Result<String, Error>) in
                switch result {
                case .success:
                    UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = VCFactory.buildTabBarVC()
                case let .failure(error):
                    self?.handle(error: error)
                }
            })
        }
    }

    // MARK: Private

    private var snacker: Snacker?

    private var authService: AuthService?

    private func handle(error: Error) {
        snacker?.show(snack: error.localizedDescription, with: .error)
        if let networkError = error as? Errors {
            switch networkError {
            case let .failedResponse(_, fields):
                fields?.forEach { field in
                    switch field.field {
                    case "login":
                        self.loginField.error = field.message
                    default:
                        break
                    }
                }
            default:
                break
            }
        }
    }

    private func localizable() {
        loginField.title = L10n.Auth.login
        passwordField.title = L10n.Auth.password
        signInButton.setTitle(L10n.Auth.action, for: .normal)
    }
}
