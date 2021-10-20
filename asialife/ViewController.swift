//
//  ViewController.swift
//  asialife
//
//  Created by 李崑睿 on 2021/10/3.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView1: UIView!
    @IBOutlet weak var containerView2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        containerView2.isHidden=true
//        self.hidesBottomBarWhenPushed = false
    }
    
    @IBAction func changContainerBtn(_ sender: UISegmentedControl) {
        print(containerView1.isHidden)
        if(containerView1.isHidden==false){
            containerView1.isHidden=true
            containerView2.isHidden=false
        }else{
            containerView1.isHidden=false
            containerView2.isHidden=true
        }
    }
    
}

