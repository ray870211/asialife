//
//  LoginButtonVC2.swift
//  asialife
//
//  Created by 李崑睿 on 2021/10/12.
//

import Foundation
import UIKit
class LoginButtonVC2: UIViewController{
    var loginControoler = LoginController()
    var account = String()
    var password = String()
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        
    }
    func setTextField(){
        loginControoler.account=accountTextField.text ?? ""
        loginControoler.password=passwordTextField.text ?? ""
    }
    
}
