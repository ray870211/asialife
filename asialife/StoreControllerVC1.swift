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
    var storeId = [String]()
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
            let tag = sender as! Int
            if let storePage = segue.destination as? StorePageController {
                storePage.storeId = storeId[tag]
                storePage.titleText = name[tag]
                storePage.imageText = storeImage[tag]
                storePage.addressText = address[tag]
                storePage.phoneText = phone[tag]
            }
        }
    }
    override func viewDidLoad() {
        postApi {
            DispatchQueue.main.async {
                for i in 0...self.name.count-1 {
                    self.imageButton[i].setImage(self.convertBase64StringToImage(imageBase64String: self.storeImage[i]),for: .normal)
                    self.imageButton[i].imageView?.contentMode = .scaleAspectFill
                    self.imageButton[i].contentVerticalAlignment = .top
                    self.imageButton[i].contentHorizontalAlignment = .center
                    self.label[i].text = self.name[i]
                    
                    
                }
            }
        }
    }
    @IBAction func clickButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ToStorePageSegue", sender: sender.tag)
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
        let url = URL(string: "\(ApiMode().url)/select_store.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let createUserResponse = try decoder.decode(StoreData.self, from: data)
                    for storeData in createUserResponse.store_data{
                        self.storeId.append(storeData.id)
                        self.name.append(storeData.name)
                        self.storeImage.append(storeData.image)
                        self.address.append(storeData.address)
                        self.phone.append(storeData.phone)
                        }
                    completionBlock()
                } catch  {
                    print(error)
                }
            }
            
        }.resume()
        
    }
    
}

