//
//  ThirdViewController.swift
//  CV_in_TB
//
//  Created by yoon tae soo on 2021/05/16.
//

import UIKit

class ThirdViewController: UIViewController {

    let tableView : UITableView = {
        
        let tbv = UITableView()
        tbv.translatesAutoresizingMaskIntoConstraints = false
        return tbv
        
    }()
    
    let uiView : UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemFill
        
        return view
        
    }()
    
    lazy var saveButton : UIButton = {
       
        let button = UIButton()
        button.setTitle("저장하기", for: .normal)
        button.addTarget(self, action: #selector(click_save), for: .touchUpInside)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
        
    }()
    
    lazy var closeButton  : UIButton = {
        
        let button = UIButton()
        button.setTitle("취소하기", for: .normal)
        button.addTarget(self, action: #selector(click_close), for: .touchUpInside)
        button.tintColor = UIColor.black
        button.setTitleColor(UIColor.black, for: .normal)
        return button
        
    }()
    
    @objc func click_close(){
        print("click_close")
        tempArray = initArray
        tableView.reloadData()
    }
    
    @objc func click_save(){
        print("click_save")
        
        manager.itemList = tempArray
        
        navigationController?.popViewController(animated: true)
    }
    
    let manager = SingletonManager.shared
    
    var tempArray : [Model] = []
    var initArray : [Model] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setConstraint()
        tempArray = manager.itemList
        initArray = tempArray
        
        tableView.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondTableViewCell")
        
        tableView.isEditing = true
    }
    
    func setConstraint(){
        view.addSubview(tableView)
        
        view.addSubview(uiView)
        
        NSLayoutConstraint.activate([
            uiView.heightAnchor.constraint(equalToConstant: 50),
            uiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            uiView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [closeButton , saveButton])
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints  = false
        
        uiView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: uiView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: uiView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: uiView.bottomAnchor)
        
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: uiView.topAnchor)
        ])
        
    }
 

}

extension ThirdViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        tempArray.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        
    }
    
    
}

extension ThirdViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArray.count - 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as? SecondTableViewCell else {return UITableViewCell()}
        
        cell.nameLabel.text = tempArray[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
//        if indexPath.row % 2 == 0 {
//            return true
//        }
            return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
//        if indexPath.row % 3 == 0 {
//            return .insert
//        }
//        else{
//            return .delete
//        }
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        if editingStyle == .delete {
            print("delete")
            tempArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
        else if editingStyle == .insert {
            print("insert")
        }
        else{
            print("None")
        }
        
    }

    
}
