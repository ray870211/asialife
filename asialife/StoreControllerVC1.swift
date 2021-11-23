//
//  LoginButtonVC2.swift
//  asialife
//
//  Created by 李崑睿 on 2021/10/12.
//

import Foundation
import UIKit

class StoreControllerVC1: UIViewController{
    
    @IBOutlet var label: [UILabel]!
    @IBOutlet var topImage: [UIImageView]!
    @IBOutlet var imageButton: [UIButton]!
    var buttonTag = 0
    var name = [String]()
    var storeImage = [String]()
    var address = [String]()
    var phone = [String]()
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "ToStorePageSegue"{
            if let sotrePage = segue.destination as? StorePageController {
//                sotrePage.storeTitle.text = name[buttonTag]
            }
        }
    }
    override func viewDidLoad() {
        postApi {
            DispatchQueue.main.async {
//                for i in 0...self.topImage.count-1{
//                    self.topImage[i].image(self.convertBase64StringToImage(imageBase64String: self.storeImage[i]),for: .normal)
//                }
                for i in 0...self.name.count-1 {
                    self.imageButton[i].setImage(self.convertBase64StringToImage(imageBase64String: self.storeImage[i]),for: .normal)
                    self.label[i].text = self.name[i]
                    
                }
            }
        }
    }
    @IBAction func clickButton(_ sender: UIButton) {
        print(sender.tag)
        buttonTag = sender.tag
        self.performSegue(withIdentifier: "ToStorePageSegue", sender: self)
        //        print(store[0].name)
    }
    
    func postApi(completionBlock: @escaping () -> Void) {
        struct StoreData: Decodable{
            let store_data : [CreateUserResponse]
        }
        struct CreateUserResponse: Decodable {
            let id: String
            let name: String
            let image: String
            let address: String
            let phone: String
        }
        let url = URL(string: "http://192.168.1.19/select_store.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    //                    print(String(data: data,encoding: .utf8))
                    let decoder = JSONDecoder()
                    let createUserResponse = try decoder.decode(StoreData.self, from: data)
                    for storeData in createUserResponse.store_data{
                        self.name.append(storeData.name)
                        self.storeImage.append(storeData.image)
                        self.address.append(storeData.address)
                        self.phone.append(storeData.phone)
                    }
                    completionBlock()
                    //                    print(createUserResponse.store_data[0].name)
                } catch  {
                    print(error)
                }
            }
            
        }.resume()
        
    }
    
}
