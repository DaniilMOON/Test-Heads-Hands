//
//  CartViewController.swift
//  OnlineShop
//
//  Created by Даниил Осипов on 29.09.2021.
//

import UIKit

class CartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        let window = UIApplication.shared.windows.first{
            $0.isKeyWindow
        }
        let vs = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Main")
        window?.rootViewController = vs
    }
}
