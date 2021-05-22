//
//  AllServiceViewController.swift
//  Project3.5
//
//  Created by yoon tae soo on 2021/05/22.
//

import UIKit

class AllServiceViewController: UIViewController {
    
    let mainTableView : UITableView = {
       
        let tbv = UITableView()
        tbv.translatesAutoresizingMaskIntoConstraints = false
        tbv.backgroundColor = UIColor.systemPurple
        return tbv
        
    }()
    
    let categoryList : [String] = ["MBC", "KBS", "SBS"]
    let list : [[String]] = [
        ["Show" , "Me", "The", "Money"],
        ["나", "혼자" , "산다"],
        ["런","닝","맨"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.systemTeal
        
        
        mainTableView.register(UINib(nibName: "AllServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "AllServiceTableViewCell")
        
        setConstraint()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self

    }
    
    func setConstraint(){
        
        view.addSubview(mainTableView)
        
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        ])
        
    }

}

extension AllServiceViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categoryList[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

extension AllServiceViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return list[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: "AllServiceTableViewCell", for: indexPath) as? AllServiceTableViewCell else {return UITableViewCell()}
        
        cell.updateUI(image: "swift", mother: list[indexPath.section][indexPath.row], child: "비어있음", state: true)
        
        return cell
        
    }

}

