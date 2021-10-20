//
//  LoginController.swift
//  asialife
//
//  Created by 李崑睿 on 2021/10/3.
//

import Foundation
import UIKit

class LoginController:UIViewController{
    @IBOutlet weak var loginBtnContainerView1: UIView!
    @IBOutlet weak var loginBtnContainerView2: UIView!
    @IBOutlet weak var fbBtn: UIButton!
    var account = String()
    var password = String()
    static let toLoginButtonVC1 = "loginButtonVC1"
    static let toLoginButtonVC2 = "loginButtonVC2"
    let viewController = ViewController()
    //    var isOutSide: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loginBtnContainerView2.isHidden=true
        fbBtn.contentVerticalAlignment = .fill
        fbBtn.contentHorizontalAlignment = .fill
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
        performSegue(withIdentifier: "ToIndexPageSegue", sender: sender)
//        self.hidesBottomBarWhenPushed = true
    }

    
   
  
//    @IBAction func insideSchoolBtn(_ sender: UIButton) {
//        loginBtnContainerView1.isHidden = true
//        loginBtnContainerView2.isHidden = false
//        isOutSide = 1
//    }
//    @IBAction func outSideSchoolBtn(_ sender: UIButton) {
//        loginBtnContainerView1.isHidden = true
//        loginBtnContainerView2.isHidden = false
//        isOutSide = 2
//    }
    
}
