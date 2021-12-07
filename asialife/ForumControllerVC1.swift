//
//  ForumControllerVC1.swift
//  asialife
//
//  Created by 李崑睿 on 2021/11/22.
//

import Foundation
import UIKit
class ForumControllerVC1: UIViewController{
    @IBOutlet var postButtons: [UIButton]!
    var postId = [String]()
    var postClass = [String]()
    var postTitle = [String]()
    var postContent = [String]()
    var postCreateTime = [String]()
    var buttonTag : Int?
    override func viewDidLoad(){
     
        postApi {
            DispatchQueue.main.async {
                if(self.postId.count>0){
                    for i in 0...self.postId.count-1 {
                        self.postButtons[i].setTitle(self.postTitle[i],for: .normal)
                    }
                }
            }
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
    @IBAction func postButtonsClick(_ sender: UIButton) {
        performSegue(withIdentifier: "ToPostControllerSegue", sender: sender.tag)
    }

}
