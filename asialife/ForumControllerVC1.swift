//
//  ForumControllerVC1.swift
//  asialife
//
//  Created by 李崑睿 on 2021/11/22.
//

import Foundation
import UIKit
class ForumControllerVC1: UIViewController{
    var postId = [String]()
    var postClass = [String]()
    var postTitle = [String]()
    var postContent = [String]()
    var postCreateTime = [String]()
    var buttonTag : Int?
    var scrollView: UIScrollView!
    var fullSize :CGSize!
    var countI:Int = 0
    var label : UILabel!
    var containerViewArray: [UIView] = []
    var userImageArray: [UIImageView] = []
    var postButtonArray: [UIButton] = []
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
        label.font = UIFont(name: label.font.fontName, size: 20)
        label.text = "論壇"
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
        scrollView.contentSize = CGSize(width: 300, height: (i+1)*200)
        containerViewArray.append(UIView())
        containerViewArray[i].frame = CGRect(x: 0, y: 50+170*(i), width: Int(fullSize.width), height: 200)
        scrollView.addSubview(containerViewArray[i])
        //image
        userImageArray.append(UIImageView())
        userImageArray[i].frame = CGRect(x: 30, y: 50, width: 50, height: 50)
        userImageArray[i].image = UIImage(named: "user1")
        containerViewArray[i].addSubview(userImageArray[i])
        //button
        postButtonArray.append(UIButton())
        postButtonArray[i].frame = CGRect(x: 100, y: 30, width: Int(fullSize.width)-120, height: 50)
        postButtonArray[i].setTitleColor(UIColor.black, for: .normal)
        postButtonArray[i].tag = i
        postButtonArray[i].setTitle(postTitle[i], for: .normal)
        postButtonArray[i].addTarget(self, action: #selector(clickPostButton), for: .touchUpInside)
        containerViewArray[i].addSubview(postButtonArray[i])
        drawLineFromPointToPoint(startX: 20, toEndingX: Int(fullSize.width)-20, startingY: 50+(i+1)*170, toEndingY: 50+(i+1)*170, ofColor: UIColor.gray, widthOfLine: 1, inView: scrollView)
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
            let post_class: String
            let post_title: String
            let post_content: String
            let post_create_time: String
        }
        let url = URL(string: "\(ApiMode().url)/select_post.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    //                    print(String(data: data,encoding: .utf8))2
                    let decoder = JSONDecoder()
                    let createUserResponse = try decoder.decode(PostData.self, from: data)
                    self.postId.removeAll()
                    self.postClass.removeAll()
                    self.postTitle.removeAll()
                    self.postContent.removeAll()
                    self.postCreateTime.removeAll()
                    for postData in createUserResponse.post_data{
                        self.postId.append(postData.post_id)
                        self.postClass.append(postData.post_class)
                        self.postTitle.append(postData.post_title)
                        self.postContent.append(postData.post_content)
                        self.postCreateTime.append(postData.post_create_time)
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




#if DEBUG
import SwiftUI
struct ForumControllerVC1Previews: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ForumControllerVC1 {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ForumControllerVC1") as! ForumControllerVC1
    }
    
    func updateUIViewController(_ uiViewController: ForumControllerVC1, context: Context) {
    }
    
    typealias UIViewControllerType = ForumControllerVC1
    
}
struct ForumControllerVC1View_Previews: PreviewProvider {
    static var previews: some View {
        ForumControllerVC1Previews()
    }
}
#endif
