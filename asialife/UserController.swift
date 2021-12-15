//
//  UserController.swift
//  asialife
//
//  Created by 李崑睿 on 2021/12/13.
//

import Foundation
import UIKit
class UserController: UIViewController{
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        let dataDecoded : Data = Data(base64Encoded: UserModel.userData.image!, options: .ignoreUnknownCharacters)!
        userImage.image = UIImage(data: dataDecoded)
        userName.text = UserModel.userData.name
    }
}
