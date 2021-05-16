//
//  ViewController.swift
//  CV_in_TB
//
//  Created by yoon tae soo on 2021/05/16.
//

import UIKit

class ViewController: UIViewController {

    let tableView : UITableView = {
        let tbv = UITableView()
        tbv.translatesAutoresizingMaskIntoConstraints = false
        tbv.backgroundColor = UIColor.systemGreen
        return tbv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setTBVConstraint()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func setTBVConstraint(){
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }


}

extension ViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension ViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {return UITableViewCell()}
            
        if indexPath.row % 2 == 0 {
                
            cell.backgroundColor = UIColor.systemOrange
            
        }
        else{
        
            let vc = MainViewController()
            self.addChild(vc)
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(vc.view)
            
            vc.mainViewController = self
            
            NSLayoutConstraint.activate([
                
                vc.view.topAnchor.constraint(equalTo: cell.topAnchor),
                vc.view.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
                vc.view.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
                vc.view.trailingAnchor.constraint(equalTo: cell.trailingAnchor)
                
            ])
            
            vc.didMove(toParent: self)
            
            
        }
        
        
        return cell
    }
    
    
    
    
}

