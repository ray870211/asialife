//
//  StorePageController.swift
//  asialife
//
//  Created by 李崑睿 on 2021/11/22.
//

import Foundation
import UIKit
class StorePageController : UIViewController{
    var imageText : String!
    var titleText : String!
    var addressText : String!
    var phoneText : String!

    @IBOutlet weak var storePageImage: UIImageView!
    @IBOutlet weak var storePageTitle: UILabel!
    @IBOutlet weak var storePageAddress: UILabel!
    @IBOutlet weak var storePagePhone: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        storePageTitle.text = titleText
        storePageAddress.text = "地址：" + addressText
        storePagePhone.text = "電話：" + phoneText
        let dataDecoded : Data = Data(base64Encoded: imageText, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        storePageImage.image = decodedimage
    }
}
