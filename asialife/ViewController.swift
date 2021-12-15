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
        print(UserModel.userData.id!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "storeControllerVC1"{
            if let storeControllerVC1 = segue.destination as? StoreControllerVC1{
//                傳的內容在裡面
//                storeControllerVC1.storeData = respondsStoreData
            }
        }
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
#if DEBUG
import SwiftUI
struct ViewControllerPreviews: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
         UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController") as! ViewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
    
    typealias UIViewControllerType = ViewController
    
}
struct ViewControllerView_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreviews()
    }
}
#endif
