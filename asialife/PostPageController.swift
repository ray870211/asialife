//
//  PostController.swift
//  asialife
//
//  Created by 李崑睿 on 2021/11/23.
//

import Foundation
import UIKit
class PostPageController: UITableViewController{
    var postId :String?
    var postClass :String!
    var postTitle :String!
    var postContent :String!
    var commentAuthor = [String]()
    var commentContent = [String]()
    override func viewDidLoad(){
        super.viewDidLoad()
//        print(postId)
//        authorLabel.text = postContent
        postApi {
            DispatchQueue.main.async {
                print(self.commentAuthor[0])
            }
        }
    }
    
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // 透過 tableView.dequeueReusableCell(withIdentifier: “Cell”, for: indexPath) 來獲取一個 cell
            let cell = tableView.dequeueReusableCell(withIdentifier:"ToDoitemCell",for: indexPath)
            cell.textLabel?.text = postId
            return cell
        }
    func postApi(complatetionBlock:()-> Void){
        struct CommentData: Decodable{
            let comment_data : [CreateUserResponse]
        }
        struct CreateUserResponse: Decodable {
            let author: String
            let content: String
            let create_time: String
        }
        let postData = "id=\(postId!))".data(using: .utf8)
        let url = URL(string: "http://192.168.1.19/select_comment.php")!
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
                    for commentData in createUserResponse.comment_data{
                        self.commentAuthor.append(commentData.author)
                        self.commentContent.append(commentData.content)
                    }
                    print(createUserResponse)
                } catch  {
                    print(error)
                }
            }
        }.resume()
    }
}

