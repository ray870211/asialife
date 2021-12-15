//
//  StorePageController.swift
//  asialife
//
//  Created by 李崑睿 on 2021/11/22.
//

import Foundation
import UIKit
class StorePageController : UIViewController{
    //parameter
    var fullSize :CGSize!
    var containerHeight = 100
    var countI:Int = 0
    //api value
    var storeId : String!
    var imageText : String!
    var titleText : String!
    var addressText : String!
    var phoneText : String!
    var commentContent = [String]()
    var commentUserName = [String]()
    var commentUserImage = [String]()
    var commentCreateTime = [String]()
    var discountId = [String]()
    var discountName = [String]()
    //element
    var discountButton: [UIButton] = []
    var containerViewArray: [UIView] = []
    var commentUserImageArray: [UIImageView] = []
    var commentCreateTimeArray: [UIButton] = []
    var commentContentArray: [UILabel] = []
    //stable element
    var storePageImage: UIImageView!
    var storePageTitle: UILabel!
    var storePageAddress: UILabel!
    var storePagePhone: UILabel!
    var discountView: UIView!
    var commentView: UIView!
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullSize = UIScreen.main.bounds.size
        scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: fullSize.width, height: fullSize.height)
        scrollView.contentSize = CGSize(width: fullSize.width, height: 2400)
        view.addSubview(scrollView)
        storePageTitle = UILabel()
        storePageTitle.frame = CGRect(x: 20, y: 0, width: fullSize.width, height: 50)
        storePageTitle.font = UIFont(name: storePageTitle.font.fontName, size: 22)
        storePageTitle.text = titleText
        scrollView.addSubview(storePageTitle)
        storePageImage = UIImageView()
        storePageImage.frame = CGRect(x: 0, y: 58, width: fullSize.width, height: 250)
        storePageImage.contentMode = .scaleAspectFit
        let dataDecoded : Data = Data(base64Encoded: imageText, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        storePageImage.image = decodedimage
        scrollView.addSubview(storePageImage)
        let storeInfo = UILabel()
        storeInfo.frame = CGRect(x: 27, y: 316, width: 116, height: 35)
        storeInfo.text = "店家資訊"
        storeInfo.font = UIFont(name: storeInfo.font.fontName, size: 22)
        scrollView.addSubview(storeInfo)
        storePageAddress = UILabel()
        storePageAddress.frame = CGRect(x: 27, y: 369, width: 347, height: 21)
        storePageAddress.font = UIFont(name: storePageAddress.font.fontName, size: 22)
        storePageAddress.text = "地址：" + addressText
        scrollView.addSubview(storePageAddress)
        storePagePhone = UILabel()
        storePagePhone.frame = CGRect(x: 27, y: 400, width: 347, height: 21)
        storePagePhone.font = UIFont(name: storePagePhone.font.fontName, size: 22)
        storePagePhone.text = "電話：" + phoneText
        scrollView.addSubview(storePagePhone)
        let discontText = UILabel()
        discontText.frame = CGRect(x: 27, y: 450, width: 116, height: 35)
        discontText.text = "優惠券"
        discontText.font = UIFont(name: discontText.font.fontName, size: 22)
        scrollView.addSubview(discontText)
        discountView = UIView()
        discountView.frame = CGRect(x: 0, y: 480, width: fullSize.width, height: 300)
        scrollView.addSubview(discountView)
        let commentTitle = UILabel()
        commentTitle.frame =  CGRect(x: 20, y: 650, width: 200, height: 50)
        commentTitle.font = UIFont(name: commentTitle.font.fontName, size: 22)
        commentTitle.text = "評論"
        commentView = UIView()
        commentView.frame = CGRect(x: 0, y: 700, width: fullSize.width, height: 800)
        commentView.backgroundColor = UIColor.systemGroupedBackground
        scrollView.addSubview(commentView)
        
        scrollView.addSubview(commentTitle)
        
        postApi {
            DispatchQueue.main.async {
                if(self.discountId.count>0){
                    for i in 0...self.discountId.count-1 {
                        self.addOneButton(i: i)
                    }
                }
            }
        }
        commentApi {
            DispatchQueue.main.async {
                if(self.commentUserName.count>0){
                    for i in 0...self.commentUserName.count-1 {
                        self.countI+=1
                        self.addOneComment(i: i)
                    }
                }
                else{
//                    let commentButton = UIButton()
//                    commentButton.frame = CGRect(x: 10, y: 100+containerHeight*(i+1)+(i*20), width: Int(fullSize.width-60), height: 40)
//                    commentButton.setTitle("留言",for:.normal)
//                    commentButton.setTitleColor(UIColor.black, for: .normal)
//                    commentButton.layer.cornerRadius = 6
//                    commentButton.layer.borderWidth = 2
//                    commentButton.layer.borderColor = UIColor(red: 0/255, green: 102/255, blue: 0, alpha: 1).cgColor
//                    commentButton.backgroundColor = UIColor.white
//                    commentButton.addTarget(self, action: #selector(self.clickCommentButton), for: .touchUpInside)
//                    self.commentView.addSubview(commentButton)
                }
            }
        }
    }
    func addOneButton(i:Int){
        discountButton.append(UIButton())
        discountButton[i].frame = CGRect(x: 10, y: 50*(i+1), width: Int(fullSize.width-40), height: 40)
        discountButton[i].setTitle(discountName[i],for:.normal)
        discountButton[i].setTitleColor(UIColor.black, for: .normal)
        discountButton[i].layer.cornerRadius = 2
        discountButton[i].layer.borderWidth = 2
        discountButton[i].layer.borderColor = UIColor(red: 0/255, green: 102/255, blue: 0, alpha: 1).cgColor
        discountView.addSubview(discountButton[i])
    }
    func addOneComment(i:Int){
//        scrollView.contentSize = CGSize(width: 300, height: (i+1)*containerHeight+200)
        containerViewArray.append(UIView())
        containerViewArray[i].frame = CGRect(x: 10, y: 60+containerHeight*(i)+(i*20), width: Int(fullSize.width)-20, height: containerHeight)
        containerViewArray[i].backgroundColor = UIColor.white
        commentView.addSubview(containerViewArray[i])
        //userName
        commentContentArray.append(UILabel())
        commentContentArray[i].frame = CGRect(x: 20 , y: 10, width: 150, height: 24)
        commentContentArray[i].text = commentUserName[i]
//        nameLabelArray[i].backgroundColor = UIColor.blue
        containerViewArray[i].addSubview(commentContentArray[i])
        //image
        commentUserImageArray.append(UIImageView())
        let dataDecoded : Data = Data(base64Encoded: commentUserImage[i], options: .ignoreUnknownCharacters)!
        commentUserImageArray[i].frame = CGRect(x: 20, y: 20, width: 40, height: 40)
        commentUserImageArray[i].image = UIImage(data: dataDecoded)
        containerViewArray[i].addSubview(commentUserImageArray[i])
        //content
        commentContentArray.append(UILabel())
        commentContentArray[i].numberOfLines=0
        commentContentArray[i].lineBreakMode = NSLineBreakMode.byWordWrapping
        commentContentArray[i].frame = CGRect(x: 80, y: 15, width: Int(fullSize.width)-150, height: 40)
        commentContentArray[i].text = commentContent[i]
        containerViewArray[i].addSubview(commentContentArray[i])
        if(i == self.commentUserName.count-1){
            let commentButton = UIButton()
            commentButton.frame = CGRect(x: 10, y: 100+containerHeight*(i+1)+(i*20), width: Int(fullSize.width-20), height: 40)
            commentButton.setTitle("留言",for:.normal)
            commentButton.setTitleColor(UIColor.black, for: .normal)
            commentButton.layer.cornerRadius = 6
            commentButton.layer.borderWidth = 2
            commentButton.layer.borderColor = UIColor(red: 0/255, green: 102/255, blue: 0, alpha: 1).cgColor
            commentButton.backgroundColor = UIColor.white
            commentButton.addTarget(self, action: #selector(clickCommentButton), for: .touchUpInside)
            commentView.addSubview(commentButton)
        }
    }
    @objc func clickCommentButton(){
        var textField = UITextField()
               //新增一個alert 選擇他的樣式
               let alert = UIAlertController(title: "留言", message: "", preferredStyle: .alert)
               let action = UIAlertAction(title: "發送", style: .default) { action in
                   //這是一個閉包 當UIAlert被點擊會發生什麼 也就是alert裡面的but被按到的地方
                   //而在閉包裡面你必須告訴編譯器在哪裡存在 self
//                   self.itemArray.append(textField.text!)
                   print(textField.text!)
                   self.addCommentApi(commentText:textField.text!)
               }
               alert.addTextField { (alertTextField) in
                   alertTextField.placeholder = "請輸入文字"
                   textField = alertTextField
               }
               //點擊
               alert.addAction(action)
               present(alert,animated: true,completion: nil)
    }
    func addCommentApi(commentText:String){
        struct CreateUserResponse: Decodable {
            let status_code: String
        }
        let postData = "user_id=\(UserModel.userData.id!)&content=\(commentText)&store_id=\(self.storeId!)".data(using: .utf8)
        let url = URL(string: "\(ApiMode().url)/store_comment.php")!
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
                    if(createUserResponse.status_code == "200"){
                        self.postApi{
                            DispatchQueue.main.async {
                                print(self.countI)
                            self.addOneComment(i: self.countI)
                            }
                        }
                    }
                } catch  {
                    print(error)
                }
            }
        }.resume()
    }
    func postApi(completionBlock: @escaping () -> Void) {
        struct DiscountData: Decodable{
            let discount_data : [CreateUserResponse]
        }
        struct CreateUserResponse: Decodable {
            let status_code: String
            let discount_id: String
            let discount_name: String
            
        }
        let postData = "id=\(storeId!)".data(using: .utf8)
        let url = URL(string: "\(ApiMode().url)/discount.php")!
        var request = URLRequest(url: url)
        request.httpBody = postData
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    //                    print(String(data: data,encoding: .utf8))
                    let decoder = JSONDecoder()
                    let createUserResponse = try decoder.decode(DiscountData.self, from: data)
                    
                    for discountData in createUserResponse.discount_data{
                        if(discountData.status_code == "200"){
                            self.discountId.append(discountData.discount_id)
                            self.discountName.append(discountData.discount_name)
                        }
                    }
                    completionBlock()
                    //                    print(createUserResponse.store_data[0].name)
                } catch  {
                    print(error)
                }
            }
            
        }.resume()
    }
    func commentApi(completionBlock: @escaping () -> Void) {
        struct DiscountData: Decodable{
            let comment_data : [CreateUserResponse]
        }
        struct CreateUserResponse: Decodable {
            let status_code: String
            let id: String
            let name: String
            let comment: String
            let create_time: String
            let score: String
            let author_image: String
        }
        let postData = "id=\(storeId!)".data(using: .utf8)
        let url = URL(string: "\(ApiMode().url)/select_store_comment.php")!
        var request = URLRequest(url: url)
        request.httpBody = postData
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    //                    print(String(data: data,encoding: .utf8))
                    let decoder = JSONDecoder()
                    let createUserResponse = try decoder.decode(DiscountData.self, from: data)
                    print()
                    for commentData in createUserResponse.comment_data{
                        if(commentData.status_code == "200"){
                            self.commentUserName.append(commentData.name)
                            self.commentContent.append(commentData.comment)
                            self.commentUserImage.append(commentData.author_image)
                            self.commentCreateTime.append(commentData.create_time)
                        }
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
