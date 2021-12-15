//
//  ForumControllerVC1.swift
//  asialife
//
//  Created by 李崑睿 on 2021/11/22.
//

import Foundation
import UIKit
class ForumControllerVC3: UIViewController{
    var postId = [String]()
    var postAuthor = [String]()
    var postClass = [String]()
    var postTitle = [String]()
    var postContent = [String]()
    var postCreateTime = [String]()
    var postAuthorImage = [String]()
    var buttonTag : Int?
    var scrollView: UIScrollView!
    var fullSize :CGSize!
    var countI:Int = 0
    var label : UILabel!
    var containerViewArray: [UIView] = []
    var userAuthorArray: [UILabel] = []
    var userImageArray: [UIImageView] = []
    var postButtonArray: [UIButton] = []
    var postCreateTimeArray: [UILabel] = []
    override func viewDidLoad(){
        fullSize = UIScreen.main.bounds.size
        //scrollView
        scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: fullSize.width, height: fullSize.height)
        view.addSubview(scrollView)
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(refreshControl), for: .valueChanged)
        //label
        label = UILabel()
        label.frame = CGRect(x: 20, y: 0, width: 200, height: 50)
        label.font = UIFont(name: label.font.fontName, size: 24)
        label.text = "學校"
        scrollView.addSubview(label)
        postApi {
            DispatchQueue.main.async {
                if(self.postId.count>0){
                    for i in 0...self.postId.count-1 {
                        self.countI+=1
                        self.addOnePost(i: i)
                    }
                }
            }
        }
    }
    @objc func refreshControl(){
        postApi{
            DispatchQueue.main.async {
                if(self.postId.count>0){
                    for i in self.countI-1...self.postId.count-1 {
                        print(i)
                        self.addOnePost(i: i)
                    }
                }
                  self.scrollView.refreshControl?.endRefreshing()
               }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    func addOnePost(i:Int){
        scrollView.contentSize = CGSize(width: 300, height: (i+1)*150+150)
        containerViewArray.append(UIView())
        containerViewArray[i].frame = CGRect(x: 0, y: 30+150*(i), width: Int(fullSize.width), height: 150)
        scrollView.addSubview(containerViewArray[i])
        //userName
        userAuthorArray.append(UILabel())
        userAuthorArray[i].frame = CGRect(x: Int(fullSize.width)-60, y: 100, width: 60, height: 50)
        userAuthorArray[i].text = postAuthor[i]
        containerViewArray[i].addSubview(userAuthorArray[i])
        //image
        userImageArray.append(UIImageView())
        let dataDecoded : Data = Data(base64Encoded: postAuthorImage[i], options: .ignoreUnknownCharacters)!
        userImageArray[i].frame = CGRect(x: 30, y: 50, width: 50, height: 50)
        userImageArray[i].image = UIImage(data: dataDecoded)
        containerViewArray[i].addSubview(userImageArray[i])
        //button
        postButtonArray.append(UIButton())
        postButtonArray[i].frame = CGRect(x: 100, y: 50, width: Int(fullSize.width)-120, height: 50)
        postButtonArray[i].setTitleColor(UIColor.black, for: .normal)
        postButtonArray[i].tag = i
        postButtonArray[i].contentHorizontalAlignment =  UIControl.ContentHorizontalAlignment.left
        postButtonArray[i].setTitle(postTitle[i], for: .normal)
        postButtonArray[i].addTarget(self, action: #selector(clickPostButton), for: .touchUpInside)
        containerViewArray[i].addSubview(postButtonArray[i])
        //createTime
        postCreateTimeArray.append(UILabel())
        postCreateTimeArray[i].frame = CGRect(x: Int(fullSize.width)-130, y: 135, width: 160, height: 12)
        postCreateTimeArray[i].text = postCreateTime[i]
        postCreateTimeArray[i].font = postCreateTimeArray[i].font.withSize(12)
        postCreateTimeArray[i].textColor = UIColor.gray
        containerViewArray[i].addSubview(postCreateTimeArray[i])
        drawLineFromPointToPoint(startX: 20, toEndingX: Int(fullSize.width)-20, startingY: 30+(i+1)*150, toEndingY: 30+(i+1)*150, ofColor: UIColor.gray, widthOfLine: 1, inView: scrollView)
    }
    @objc func clickPostButton(sender: UIButton!){
        performSegue(withIdentifier: "ToPostControllerSegue", sender: sender.tag)
    }
    func postApi(completionBlock: @escaping () -> Void) {
        struct PostData: Decodable{
            let post_data : [CreateUserResponse]
        }
        struct CreateUserResponse: Decodable {
            let post_id: String
            let post_author: String
            let post_class: String
            let post_title: String
            let post_content: String
            let post_create_time: String
            let post_author_image : String
        }
        let postData = "class=2".data(using: .utf8)
        let url = URL(string: "\(ApiMode().url)/select_post.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    //                    print(String(data: data,encoding: .utf8))2
                    let decoder = JSONDecoder()
                    let createUserResponse = try decoder.decode(PostData.self, from: data)
                    self.postId.removeAll()
                    self.postAuthor.removeAll()
                    self.postClass.removeAll()
                    self.postTitle.removeAll()
                    self.postContent.removeAll()
                    self.postCreateTime.removeAll()
                    self.postAuthorImage.removeAll()
                    for postData in createUserResponse.post_data{
                        self.postId.append(postData.post_id)
                        self.postAuthor.append(postData.post_author)
                        self.postClass.append(postData.post_class)
                        self.postTitle.append(postData.post_title)
                        self.postContent.append(postData.post_content)
                        self.postCreateTime.append(postData.post_create_time)
                        self.postAuthorImage.append(postData.post_author_image)
                    }
                    completionBlock()
                    //                    print(createUserResponse.store_data[0].name)
                } catch  {
                    print(error)
                }
            }
        }.resume()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPostControllerSegue" {
            let tag = sender as! Int
            if let targetController = segue.destination as? PostPageController{
                print(tag)
                targetController.postId = postId[tag]
                targetController.postClass = postClass[tag]
                targetController.postTitle = postTitle[tag]
                targetController.postContent = postContent[tag]
            }
        }
    }
}





