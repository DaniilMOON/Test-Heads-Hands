//
//  ViewController.swift
//  Homework_2_registration
//
//  Created by Даниил Осипов on 20.09.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.layer.masksToBounds = true
        nameTextField.layer.cornerRadius = 12
        surnameTextField.layer.masksToBounds = true
        surnameTextField.layer.cornerRadius = 12
        birthdayTextField.layer.masksToBounds = true
        birthdayTextField.layer.cornerRadius = 12
        loginTextField.layer.masksToBounds = true
        loginTextField.layer.cornerRadius = 12
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 12
        signUpButton.layer.cornerRadius = 12
    }

    private func checkBirthday(birthdayDate: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let date = dateFormatter.date(from: birthdayDate) {
            let curDateString = dateFormatter.string(from: Date())
            if let curDate = dateFormatter.date(from: curDateString) {
                return date < curDate
            }
        }
        return false
    }
    
    @IBAction func signUp(_ sender: Any) {
        guard let name = nameTextField.text, let surname = surnameTextField.text, let birthdayDate = birthdayTextField.text,
              let login = loginTextField.text, let password = passwordTextField.text else {
            return
        }
        
        let flagBirthdayDate: Bool = (birthdayDate != "") && checkBirthday(birthdayDate: birthdayDate)
        nameTextField.backgroundColor = (name != "") ? .white : .red
        surnameTextField.backgroundColor = (surname != "") ? .white : .red
        birthdayTextField.backgroundColor = flagBirthdayDate ? .white : .red
        loginTextField.backgroundColor = (login != "") ? .white : .red
        passwordTextField.backgroundColor = (password != "") ? .white : .red
        
        if (name != "" && surname != "" && login != "" && password != "" && flagBirthdayDate) {
            signUpButton.backgroundColor = .systemGreen
        } else {
            signUpButton.backgroundColor = .systemBlue
        }
    }
    
}

