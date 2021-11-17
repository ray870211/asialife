//
//  ViewController.swift
//  asialife
//
//  Created by 李崑睿 on 2021/10/3.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView1: UIView!
    @IBOutlet weak var containerView2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postApi()
    }
    
    @IBAction func changContainerBtn(_ sender: UISegmentedControl) {
        print(containerView1.isHidden)
        if(containerView1.isHidden==false){
            containerView1.isHidden=true
            containerView2.isHidden=false
            
        }else{
            containerView1.isHidden=false
            containerView2.isHidden=true
        }
    }
    func postApi(){
        struct StoreData: Decodable{
            let store_data : [CreateUserResponse]
        }
        struct CreateUserResponse: Decodable {
            let id: String
            let name: String
            let image: String
        }
        let url = URL(string: "http://192.168.1.19//select_store.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    //                    print(String(data: data,encoding: .utf8))
                    let decoder = JSONDecoder()
                    let createUserResponse = try decoder.decode(StoreData.self, from: data)
                
                    print(createUserResponse.store_data[1])
                    
                } catch  {
                    print(error)
                }
            }
        }.resume()
    }
}

