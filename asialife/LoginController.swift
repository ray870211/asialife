//
//  LoginController.swift
//  asialife
//
//  Created by 李崑睿 on 2021/10/3.
//

import Foundation
import UIKit
import CoreData

class LoginController:UIViewController{
    
    @IBOutlet weak var loginBtnContainerView1: UIView!
    @IBOutlet weak var loginBtnContainerView2: UIView!
    @IBOutlet weak var fbBtn: UIButton!
    var account = String()
    var password = String()
    static let toLoginButtonVC1 = "loginButtonVC1"
    static let toLoginButtonVC2 = "loginButtonVC2"
//    let viewController = ViewController()
    let loginButtonVC2 =  LoginButtonVC2()
    //    var isOutSide: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        loginBtnContainerView2.isHidden=true
        fbBtn.contentVerticalAlignment = .fill
        fbBtn.contentHorizontalAlignment = .fill
        //        getLoginData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == LoginController.toLoginButtonVC1{
            if let loginButtonVC1 = segue.destination as? LoginButtonVC1 {
                loginButtonVC1.loginBtnVC1 = loginBtnContainerView1
                loginButtonVC1.loginBtnVC2 = loginBtnContainerView2
            }
        }
        if segue.identifier == LoginController.toLoginButtonVC2{
            if let loginButtonVC2 = segue.destination as? LoginButtonVC2{
                
            }
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
//        loginButtonVC2.setText()
//        print(loginButtonVC2.accountTextField.text ?? "no")
        print(TextFieldModel.sharedModel.accountText ?? "")
        account = TextFieldModel.sharedModel.accountText ?? ""
        if(account=="123"){
            performSegue(withIdentifier: "ToIndexPageSegue", sender: sender)
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
}


