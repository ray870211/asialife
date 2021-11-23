//
//  ForumController.swift
//  asialife
//
//  Created by 李崑睿 on 2021/11/22.
//

import Foundation
import UIKit
class ForumController: UIViewController{
    @IBOutlet var containerView: [UIView]!
    var postClass : String?
    override func viewDidLoad(){
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "toAddPostController"{
            if let addPostController = segue.destination as? AddPostController {
                addPostController.postClass = postClass ?? "0"
            }
        }
    }
    @IBAction func changContainerBtn(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        switch sender.selectedSegmentIndex{
        case 0:
            containerView[0].isHidden = false
            containerView[1].isHidden = true
            containerView[2].isHidden = true
            postClass = "0"
        case 1:
            containerView[0].isHidden = true
            containerView[1].isHidden = false
            containerView[2].isHidden = true
            postClass = "1"
        case 2:
            containerView[0].isHidden = true
            containerView[1].isHidden = true
            containerView[2].isHidden = false
            postClass = "2"
        default:
            print("123")
        }
    }
    
}
