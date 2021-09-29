//
//  ViewController.swift
//  OnlineShop
//
//  Created by Даниил Осипов on 27.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginView: TextInput!
    @IBOutlet weak var passwordView: TextInput!
    @IBOutlet weak var signInOutlet: LoadingButton!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInOutlet.layer.cornerRadius = 12
        stackView.setCustomSpacing(10, after: loginView)
        stackView.setCustomSpacing(30, after: passwordView)
        
        loginView.setText(textAdd: "Login")
        loginView.setIsSecure(isSecureAdd: false)
        
        passwordView.setText(textAdd: "Password")
        passwordView.setIsSecure(isSecureAdd: true)
    }
    
    private func checkLogin(str: String) -> Bool {
        if str.count < 5 {
            return false
        }
        return true
    }
    
    private func validLogin(str: String) -> String {
        if str.count == 0 {
            return "The field is not filled"
        } else if !checkLogin(str: str) {
            return "The field is filled in incorrectly"
        }
        return ""
    }
    
    private func checkPassword(str: String) -> Bool {
        if str.count < 10 {
            return false
        }
        return true
    }
    
    private func validPassword(str: String) -> String {
        if str.count == 0 {
            return "The field is not filled"
        } else if !checkPassword(str: str) {
            return "The field is filled in incorrectly"
        }
        return ""
    }
    
    @IBAction func signInButton(_ sender: Any) {
        signInOutlet.animateButton(shouldLoad: true)
        loginView.setError(errorAdd: validLogin(str: loginView.getTextInTextField() ?? ""))
        passwordView.setError(errorAdd: validPassword(str: passwordView.getTextInTextField() ?? ""))
        let seconds = 4.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.signInOutlet.animateButton(shouldLoad: false)
        }
        
    }
    
}

