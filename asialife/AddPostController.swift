//
//  AddPostController.swift
//  asialife
//
//  Created by 李崑睿 on 2021/11/22.
//

import Foundation
import UIKit
class AddPostController: UIViewController, UITextFieldDelegate{
    var refreshControl:UIRefreshControl!
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var postContent: UITextField!
    var postClass : String = ""
    override func viewDidLoad(){
        postTitle.delegate = self
        postContent.delegate = self
    }
    
    @IBAction func AddPostButtonClick(_ sender: UIButton) {
        print(postTitle.text!)
        if(postTitle.text! == "" || postContent.text! == ""){
            let controller = UIAlertController(title: "錯誤", message: "標題或內文不可為空", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            self.present(controller, animated: true, completion: nil)
        }else{
            postApi()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
               textField.resignFirstResponder()
               return true
         }
    func postApi(){
        struct CreateUserResponse: Decodable {
            let status_code: String
        }
        let postData = "title=\(postTitle.text!)&class=\(postClass)&user=ray&content=\(postContent.text!)".data(using: .utf8)
        let url = URL(string: "\(ApiMode().url)/add_post.php")!
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
                            let controller = UIAlertController(title: "提示", message: "成功", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            controller.addAction(okAction)
                            self.present(controller, animated: true, completion: nil)
                        }
                    }
                    if(createUserResponse.status_code=="404"){
                        DispatchQueue.main.async {
                            //切換到主線程
                            let controller = UIAlertController(title: "錯誤", message: "連線失敗", preferredStyle: .alert)
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
