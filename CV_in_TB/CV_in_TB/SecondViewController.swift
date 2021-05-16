//
//  SecondViewController.swift
//  CV_in_TB
//
//  Created by yoon tae soo on 2021/05/16.
//

import UIKit

class SecondViewController: UIViewController {

    let tableView : UITableView = {
        
        let tbv = UITableView()
        tbv.translatesAutoresizingMaskIntoConstraints = false
        return tbv
    }()
    
    let totalService : [String] = [
        "케어",
        "Show",
        "Me",
        "The",
        "Money"
    ]
    
    var appService : [String] = []
    
    let manager = SingletonManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.yellow
       
        tableView.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondTableViewCell")
        
        setConstraint()
        resetAppService()
        navigationRightBtn()
        tableView.dataSource = self
        tableView.delegate = self
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        resetAppService()
        
        tableView.reloadData()
        
    }
    
    func navigationRightBtn(){
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 4))
//        button.setImage(UIImage(named: "swift"), for: .normal)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .left
        button.backgroundColor = UIColor.systemTeal
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(click))
//            UIBarButtonItem(image: UIImage(named: "swift"), style: .done, target: self, action: #selector(click))
    }
    
    @objc func click(){
        let vc = ThirdViewController()
        vc.view.backgroundColor = UIColor.green
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func resetAppService(){
        appService = totalService.filter({ (item) -> Bool in
            
            for i in manager.itemList{
                if item == i.name {return false}
            }
            
            return true
        })
    }
    
    func setConstraint(){
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }

}

extension SecondViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "등록된 서비스"
        }
        
        return "전체 서비스"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let item = manager.itemList.remove(at: indexPath.row)
            appService.append(item.name)
        }
        else{
            let item = appService[indexPath.row]
            
            if manager.itemList.count < 2 {
                
                manager.itemList.insert(Model(color: UIColor.yellow, name: item), at: 0)
            }
            else{
            
            manager.itemList.insert(Model(color: UIColor.yellow, name: item), at: manager.itemList.count - 1)
                
            }
            appService.remove(at: indexPath.row)
        }
        
        tableView.reloadData()
        
    }
    
}

extension SecondViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return manager.itemList.count - 1
        }
        
        return appService.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as? SecondTableViewCell else {return UITableViewCell()}
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.green
        }
        else{
            cell.backgroundColor = UIColor.red
        }
        
        if indexPath.section == 0 {
            cell.nameLabel.text = manager.itemList[indexPath.row].name
        }
        else{
            cell.nameLabel.text = appService[indexPath.row]
        }
        
        return cell
    }
    
    
    
}
