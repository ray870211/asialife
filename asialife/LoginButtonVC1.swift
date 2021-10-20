//
//  LoginButtonController.swift
//  asialife
//
//  Created by 李崑睿 on 2021/10/11.
//

import UIKit
class LoginButtonVC1:UIViewController{
    var loginBtnVC1:UIView!
    var loginBtnVC2:UIView!
    var sendBackData =  String()
    let loginControoler=LoginController()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func loginButton1(_ sender: UIButton) {
//        loginControoler.selectVC()
        loginBtnVC1.isHidden=true
        loginBtnVC2.isHidden=false
    }
    @IBAction func loginButton2(_ sender: UIButton) {
//        loginControoler.selectVC()
        loginBtnVC1.isHidden=true
        loginBtnVC2.isHidden=false
    }
}
