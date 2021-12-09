//
//  PostController.swift
//  asialife
//
//  Created by 李崑睿 on 2021/11/23.
//

import Foundation
import UIKit

class PostPageController: UIViewController{
    
    var postId :String?
    var postClass :String!
    var postTitle :String!
    var postContent :String!
    var commentAuthor = [String]()
    var commentContent = [String]()
    var commentScore = [String]()
    var itemArray = [String]()
    var scrollView: UIScrollView!
    var label: UILabel!
    var fullSize :CGSize!
    var image: UIImageView!
    var commentButton : UIButton!
    var commentView: UIView!
    var commentViewArray:[UIView] = []
    var userImageArray:[UIImageView] = []
    var authorArray:[UILabel] = []
    var labelArray:[UILabel] = []
    var upButtonArray:[UIButton] = []
    var downButtonArray:[UIButton] = []
    var scoreArray:[UILabel] = []
    var countI:Int = 0
    struct row{
        var x:Int
        var y:Int
        var fullSize:Int
        var label = UILabel()
        
        func setLabelFrame(){
            label.frame = CGRect(x: x, y: y, width: fullSize, height: 50)
        }
        func setText(labelText:String){
            label.text = labelText
        }
        //user image
        var image = UIImageView()
        func setImageFrame(){
            image.frame = CGRect(x: x+20, y: y+50, width: 50, height: 50)
        }
        func setUserImage(imgName:String){
            image.image = UIImage(named: imgName)
        }
    }
    func drawLineFromPointToPoint(startX: Int, toEndingX endX: Int, startingY startY: Int, toEndingY endY: Int, ofColor lineColor: UIColor, widthOfLine lineWidth: CGFloat, inView view: UIView) {

        let path = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: endX, y: endY))

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        view.layer.addSublayer(shapeLayer)
    }
    override func viewDidLoad(){
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        super.viewDidLoad()
        fullSize = UIScreen.main.bounds.size
        //scrollView
        scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: fullSize.width, height: fullSize.height)
        view.addSubview(scrollView)
        
        //label
        label = UILabel()
        label.frame = CGRect(x: 20, y: 0, width: 200, height: 50)
        label.font = UIFont(name: label.font.fontName, size: 20)
        label.text = postTitle
        scrollView.addSubview(label)
        //button
        commentButton = UIButton(type: .contactAdd)
        commentButton.center = CGPoint(x: fullSize.width - 20, y: 50)
        commentButton.setTitle("留言", for: .normal)
        commentButton.addTarget(self, action: #selector(clickCommentButton), for: .touchUpInside)
        scrollView.addSubview(commentButton)
        postApi {
            DispatchQueue.main.async {
                for i in 0...self.commentAuthor.count-1{
                    self.countI+=1
                    self.addOneComment(i: i)
                    print(self.countI)
                    print(i)
                }
            }
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
    func addOneComment(i:Int){
        scrollView.contentSize = CGSize(width: 300, height: (i+1)*200)

        commentViewArray.append(UIView())
        commentViewArray[i].frame = CGRect(x: 0, y: 50+170*(i), width: Int(fullSize.width), height: 200)
      
        commentViewArray[i].translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(commentViewArray[i])
        //userimage
        userImageArray.append(UIImageView())
        userImageArray[i].image =  UIImage(named: "user1")
        userImageArray[i].frame = CGRect(x: 30, y: 50, width: 50, height: 50)
        commentViewArray[i].addSubview(userImageArray[i])

        //author
        authorArray.append(UILabel())
        authorArray[i].frame = CGRect(x: 25, y: 20, width: Int(fullSize.width), height: 20)
        authorArray[i].text = commentAuthor[i]
        commentViewArray[i].addSubview(authorArray[i])
        //commentContent
        labelArray.append(UILabel())
        labelArray[i].numberOfLines=0
        labelArray[i].lineBreakMode = NSLineBreakMode.byWordWrapping
        labelArray[i].frame = CGRect(x: 100, y: 30, width: Int(fullSize.width)-120, height: 50)
//        NSLayoutConstraint(item: labelArray[i] , attribute: .trailing, relatedBy: .equal, toItem: commentViewArray[i], attribute: .trailing, multiplier: 1, constant: -10).isActive = true
        labelArray[i].text = commentContent[i]
        commentViewArray[i].addSubview(labelArray[i])
        //score
        scoreArray.append(UILabel())
        scoreArray[i].frame = CGRect(x: 18, y: 73, width: 15, height: 15)
        scoreArray[i].text = commentScore[i]
        commentViewArray[i].addSubview(scoreArray[i])
        //button
        upButtonArray.append(UIButton())
        upButtonArray[i].setImage(UIImage(named: "arrow-up"), for: .normal)
        upButtonArray[i].frame = CGRect(x: 8, y: 50, width: 30, height: 30)
        commentViewArray[i].addSubview(upButtonArray[i])
        //button
        downButtonArray.append(UIButton())
        downButtonArray[i].setImage(UIImage(named: "arrow-down"), for: .normal)
        downButtonArray[i].frame = CGRect(x: 8, y: 80, width: 30, height: 30)
        commentViewArray[i].addSubview(downButtonArray[i])
        //line
        drawLineFromPointToPoint(startX: 20, toEndingX: Int(fullSize.width)-20, startingY: 50+(i+1)*170, toEndingY: 50+(i+1)*170, ofColor: UIColor.gray, widthOfLine: 1, inView: scrollView)
    }
        
    func addCommentApi(commentText:String){
        struct CreateUserResponse: Decodable {
            let status_code: String
        }
        let postData = "user=ray&content=\(commentText)&post_id=\(self.postId!)".data(using: .utf8)
        let url = URL(string: "\(ApiMode().url)/comment.php")!
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
                    print(createUserResponse)
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
    func postApi(complatetionBlock: @escaping ()-> Void){
        struct CommentData: Decodable{
            let comment_data : [CreateUserResponse]
        }
        struct CreateUserResponse: Decodable {
            let author: String
            let content: String
            let create_time: String
            let score: String
        }
        let postData = "id=\(postId!)".data(using: .utf8)
        let url = URL(string: "\(ApiMode().url)/select_comment.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    //                    print(String(data: data,encoding: .utf8))
                    let decoder = JSONDecoder()
                    let createUserResponse = try decoder.decode(CommentData.self, from: data)
                    self.commentAuthor.removeAll()
                    self.commentContent.removeAll()
                    for commentData in createUserResponse.comment_data{
                        
                        self.commentAuthor.append(commentData.author)
                        self.commentContent.append(commentData.content)
                        self.commentScore.append(commentData.score)
                    }
                    print(createUserResponse.comment_data)
                    complatetionBlock()
                } catch  {
                    print(error)
                }
            }
        }.resume()
    }
}


