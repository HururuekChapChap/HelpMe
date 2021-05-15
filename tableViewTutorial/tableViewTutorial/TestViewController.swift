//
//  TestViewController.swift
//  tableViewTutorial
//
//  Created by yoon tae soo on 2021/05/16.
//

import UIKit

class TestViewController: UIViewController {

    let manager = SingletonManager.shared
    
    var callBack : (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.yellow
    }

    @IBAction func addButton(_ sender: UIButton) {
        
        print("ADD Item")
        
        manager.items.append(ShortCutModel(name: "바로가기", image: UIImage(named: "swift")!))
        
        callBack?()
    }
}
