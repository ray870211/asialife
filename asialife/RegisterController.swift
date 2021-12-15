//
//  registerControoler.swift
//  asialife
//
//  Created by 李崑睿 on 2021/12/12.
//

import Foundation
import UIKit
import WebKit
class RegisterController: UIViewController{
//    @IBOutlet weak var web: WKWebView!
  
    @IBOutlet weak var web: WKWebView!
    override func viewDidLoad() {
       
        super.viewDidLoad()
        if let url = URL(string: "\(ApiMode().url)/register.html"){
            let request = URLRequest(url: url)
            web.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
            web.load(request)
        }
    }
}
