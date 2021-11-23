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
    var email = String()
    var password = String()
    var responseData:[String] = []
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
        email = "ray870211@gmail.com"
        password = "12345"
        postApi()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //鍵盤
        self.view.endEditing(true)
    }
    
    func getApi(email:String , password:String){
        let url = URL(string: "http://172.20.10.3/search.php?email=\(email)&password=\(password)")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
               let content = String(data: data, encoding: .utf8) {
                print(content)
                
            }
        }.resume()
    }
    func postApi(){
        struct CreateUserResponse: Decodable {
            let status_code: String
            let message: String
        }
        let postData = "email=\(email)&password=\(password)".data(using: .utf8)
        let url = URL(string: "http://192.168.1.19//login.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    //                    print(String(data: data,encoding: .utf8))
                    let decoder = JSONDecoder()
                    let createUserResponse = try decoder.decode(CreateUserResponse.self, from: data)
                    if(createUserResponse.status_code=="200"){
                        DispatchQueue.main.async {
                            //切換到主線程
                            // UIView usage
                            self.performSegue(withIdentifier: "ToIndexPageSegue", sender: self)
                        }
                    }
                    if(createUserResponse.status_code=="404"){
                        DispatchQueue.main.async {
                            //切換到主線程
                            let controller = UIAlertController(title: "錯誤", message: "帳號或密碼錯誤", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            controller.addAction(okAction)
                            self.present(controller, animated: true, completion: nil)
                        }
                    }
                    print(createUserResponse)
                } catch  {
                    print(error)
                }
            }
        }.resume()
    }
}


