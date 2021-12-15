//
//  PostController.swift
//  asialife
//
//  Created by 李崑睿 on 2021/11/23.
//

import Foundation
import UIKit
class scoreButton: UIButton{
    var id :String?
    var is_add: Int?
}
class PostPageController: UIViewController{
    
    var postId :String?
    var postClass :String!
    var postTitle :String!
    var postContent :String!
    
    var commentId = [String]()
    var commentAuthor = [String]()
    var commentContent = [String]()
    var commentScore = [String]()
    var authorImage = [String]()
    var createTime = [String]()
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
    var createTimeArray:[UILabel] = []
    var labelArray:[UILabel] = []
    var upButtonArray:[scoreButton] = []
    var downButtonArray:[scoreButton] = []
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
        scrollView.backgroundColor = UIColor.systemGroupedBackground
        //label
        label = UILabel()
        label.frame = CGRect(x: 20, y: 0, width: 200, height: 50)
        label.font = UIFont(name: label.font.fontName, size: 22)
        label.text = postTitle
        scrollView.addSubview(label)
        //button
        commentButton = UIButton(type: .contactAdd)
        commentButton.center = CGPoint(x: fullSize.width - 20, y: 30)
        commentButton.setTitle("留言", for: .normal)
        commentButton.addTarget(self, action: #selector(clickCommentButton), for: .touchUpInside)
        scrollView.addSubview(commentButton)
        postApi {
            DispatchQueue.main.async {
                for i in 0...self.commentAuthor.count-1{
                    self.countI+=1
                    self.addOneComment(i: i)
                    
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
        scrollView.contentSize = CGSize(width: 300, height: (i+1)*200+60)

        commentViewArray.append(UIView())
        commentViewArray[i].frame = CGRect(x: 20, y: 60+170*(i)+(i*20), width: Int(fullSize.width)-40, height: 170)
        commentViewArray[i].backgroundColor = UIColor.white
        commentViewArray[i].translatesAutoresizingMaskIntoConstraints = false
        print(50+170*i)
//        if(i%2==0){
//            commentViewArray[i].backgroundColor = UIColor.blue
//        }else{
//            commentViewArray[i].backgroundColor = UIColor.red
//        }
        scrollView.addSubview(commentViewArray[i])
        //userimage
        userImageArray.append(UIImageView())
        let dataDecoded : Data = Data(base64Encoded: authorImage[i], options: .ignoreUnknownCharacters)!
        userImageArray[i].image = UIImage(data: dataDecoded)
        userImageArray[i].frame = CGRect(x: 30, y: 60, width: 40, height: 40)
        commentViewArray[i].addSubview(userImageArray[i])

        //author
        authorArray.append(UILabel())
        authorArray[i].frame = CGRect(x: 25, y: 20, width: Int(fullSize.width), height: 20)
        authorArray[i].font = authorArray[i].font.withSize(20)
        authorArray[i].text = commentAuthor[i]
        commentViewArray[i].addSubview(authorArray[i])
        //commentContent
        labelArray.append(UILabel())
        labelArray[i].numberOfLines=0
        labelArray[i].lineBreakMode = NSLineBreakMode.byWordWrapping
        labelArray[i].frame = CGRect(x: 100, y: 30, width: Int(fullSize.width)-150, height: 120)
//        labelArray[i].backgroundColor = UIColor.green
        labelArray[i].text = commentContent[i]
        commentViewArray[i].addSubview(labelArray[i])
        //score
        scoreArray.append(UILabel())
        scoreArray[i].frame = CGRect(x: 15, y: 73, width: 15, height: 15)
        scoreArray[i].text = commentScore[i]
        commentViewArray[i].addSubview(scoreArray[i])
        //button
        upButtonArray.append(scoreButton())
        upButtonArray[i].setImage(UIImage(named: "arrow-up"), for: .normal)
        upButtonArray[i].frame = CGRect(x: 5, y: 50, width: 30, height: 30)
        upButtonArray[i].id = commentId[i]
        upButtonArray[i].is_add = 1
        upButtonArray[i].addTarget(self, action: #selector(scoreApi), for: .touchUpInside)
        commentViewArray[i].addSubview(upButtonArray[i])
        //button
        downButtonArray.append(scoreButton())
        downButtonArray[i].setImage(UIImage(named: "arrow-down"), for: .normal)
        downButtonArray[i].frame = CGRect(x: 5, y: 80, width: 30, height: 30)
        downButtonArray[i].id = commentId[i]
        downButtonArray[i].is_add = 0
        downButtonArray[i].addTarget(self, action: #selector(scoreApi), for: .touchUpInside)
        commentViewArray[i].addSubview(downButtonArray[i])
        //createTime
        createTimeArray.append(UILabel())
        createTimeArray[i].frame = CGRect(x: Int(fullSize.width)-170, y: 150, width: 160, height: 12)
        createTimeArray[i].text = createTime[i]
        createTimeArray[i].font = createTimeArray[i].font.withSize(12)
        createTimeArray[i].textColor = UIColor.gray
        commentViewArray[i].addSubview(createTimeArray[i])
        //line
//        drawLineFromPointToPoint(startX: 20, toEndingX: Int(fullSize.width)-20, startingY: 50+(i+1)*170, toEndingY: 50+(i+1)*170, ofColor: UIColor.gray, widthOfLine: 3, inView: scrollView)
    }
        
    func addCommentApi(commentText:String){
        struct CreateUserResponse: Decodable {
            let status_code: String
        }
        let postData = "id=\(UserModel.userData.id!)&user=\(UserModel.userData.name!)&content=\(commentText)&post_id=\(self.postId!)".data(using: .utf8)
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
    @objc func scoreApi(_ sender: scoreButton){
        struct CreateUserResponse: Decodable {
            let status_code: String
            let score: String
        }
        print(sender.id!)
        let postData = "id=\(sender.id!)&is_add=\(sender.is_add!)".data(using: .utf8)
        let url = URL(string: "\(ApiMode().url)/score.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let createUserResponse = try decoder.decode(CreateUserResponse.self, from: data)
                    if(createUserResponse.status_code == "200"){
                        DispatchQueue.main.async {
                        let arrIndex = self.commentId.firstIndex(of: (sender.id!))
                        self.scoreArray[arrIndex!].text = createUserResponse.score
                            print(arrIndex!)
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
            let id: String
            let author: String
            let content: String
            let create_time: String
            let score: String
            let author_image: String
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
                    self.commentId.removeAll()
                    self.commentScore.removeAll()
                    self.authorImage.removeAll()
                    self.createTime.removeAll()
                    for commentData in createUserResponse.comment_data{
                        self.commentId.append(commentData.id)
                        self.commentAuthor.append(commentData.author)
                        self.commentContent.append(commentData.content)
                        self.commentScore.append(commentData.score)
                        self.authorImage.append(commentData.author_image)
                        self.createTime.append(commentData.create_time)
                    }
                    complatetionBlock()
                } catch  {
                    print(error)
                }
            }
        }.resume()
    }
}


