//
//  StoreControllerVC2.swift
//  asialife
//
//  Created by 李崑睿 on 2021/12/15.
//

import Foundation
import UIKit

class StoreControllerVC2: UIViewController{
    var storeId = [String]()
    var name = [String]()
    var storeImage = [String]()
    var address = [String]()
    var phone = [String]()
    var fullSize :CGSize!
    var scrollView: UIScrollView!
    var containerViewArray: [UIView] = []
    var containerHeight = 200
    var nameLabelArray: [UILabel] = []
    var storeImageViewArray: [UIImageView] = []
    var imageButtonArray: [UIButton] = []
    override func viewDidLoad() {
        fullSize = UIScreen.main.bounds.size
        //scrollView
        scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: fullSize.width, height: fullSize.height)
        view.addSubview(scrollView)
        scrollView.refreshControl = UIRefreshControl()
        postApi {DispatchQueue.main.async {
            self.scrollView.refreshControl?.addTarget(self, action: #selector(self.refreshControl), for: .valueChanged)
                            if(self.storeId.count>0){
                    for i in 0...self.storeId.count-1 {
                        self.addOneStore(i: i)
                    }
                }
            
            }
        }
    }
    @objc func refreshControl(){
        postApi{
            DispatchQueue.main.async {
//                if(self.storeId.count>0){
//                    for i in self.storeId-1...self.storeId.count-1 {
//                        print(i)
//                        self.addOneStore(i: i)
//                    }
//                }
                  self.scrollView.refreshControl?.endRefreshing()
               }
        }
        
    }
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
    func addOneStore(i:Int){
        scrollView.contentSize = CGSize(width: 300, height: (i+1)*containerHeight+200)
        containerViewArray.append(UIView())
        containerViewArray[i].frame = CGRect(x: 0, y: 30+containerHeight*(i), width: Int(fullSize.width), height: containerHeight)
//        if(i%2==1){
//            containerViewArray[i].backgroundColor = UIColor.red
//        }else{
//            containerViewArray[i].backgroundColor = UIColor.yellow
//        }
        scrollView.addSubview(containerViewArray[i])
        //userName
        nameLabelArray.append(UILabel())
        nameLabelArray[i].frame = CGRect(x: 20 , y: 10, width: 150, height: 24)
        nameLabelArray[i].text = name[i]
//        nameLabelArray[i].backgroundColor = UIColor.blue
        containerViewArray[i].addSubview(nameLabelArray[i])
        //image
        storeImageViewArray.append(UIImageView())
        let dataDecoded : Data = Data(base64Encoded: storeImage[i], options: .ignoreUnknownCharacters)!
        storeImageViewArray[i].frame = CGRect(x: 30, y: 50, width: 50, height: 50)
        storeImageViewArray[i].image = UIImage(data: dataDecoded)
        //button
        imageButtonArray.append(UIButton())
        imageButtonArray[i].frame = CGRect(x: 20, y: 50, width: Int(fullSize.width)-40, height: 109)
        imageButtonArray[i].tag = i
        imageButtonArray[i].imageView?.contentMode = .scaleAspectFill
        imageButtonArray[i].contentVerticalAlignment = .top
        imageButtonArray[i].contentHorizontalAlignment = .center
        imageButtonArray[i].setImage(self.convertBase64StringToImage(imageBase64String: self.storeImage[i]),for: .normal)
        imageButtonArray[i].addTarget(self, action: #selector(clickStoreButton), for: .touchUpInside)
        containerViewArray[i].addSubview(imageButtonArray[i])
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
    @objc func clickStoreButton(sender: UIButton!){
        performSegue(withIdentifier: "ToStorePageSegue", sender: sender.tag)
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
                    //                    print(String(data: data,encoding: .utf8))
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
                    //                    print(createUserResponse.store_data[0].name)
                } catch  {
                    print(error)
                }
            }
        }.resume()
        
    }
}
