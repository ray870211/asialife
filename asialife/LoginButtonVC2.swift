//
//  LoginButtonVC2.swift
//  asialife
//
//  Created by 李崑睿 on 2021/10/12.
//

import Foundation
import UIKit
class LoginButtonVC2: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad(){
        accountTextField.delegate = self
        passwordTextField.delegate = self
        view.isUserInteractionEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
        TextFieldModel.sharedModel.accountText = accountTextField.text
           return true
     }
   
}
