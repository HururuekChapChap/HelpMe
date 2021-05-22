//
//  tempCell.swift
//  Project3.5
//
//  Created by yoon tae soo on 2021/05/22.
//

import UIKit

//TableViewCell을 넣을 것이다.
class tempCell : UITableViewCell{
    
    let label : UILabel = {
        
        let label = UILabel()
        label.text = "hello world"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mainTableView : UITableView = {
        
        let tableView = OwnTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.clear
        
        return tableView
    }()
    
    let category : [String] = ["English", "한국어", "En국어"]
    
    var categoryList : [[String]] = [
    
        ["A","B","C","D","E","F","G","H"],
        ["가","나","다","라","마","바","사","아"],
        ["Aㅏ","Bㅏ","Cㅏ","Dㅏ","Eㅏ","Fㅏ","Gㅏ","Hㅏ"],
    
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        mainTableView.register(UINib(nibName: "AddServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "AddServiceTableViewCell")
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.isScrollEnabled = false
        
        mainTableView.tableFooterView = UIView() //불필요한 라인 제거
        setupConstraint()
        
        mainTableView.isEditing = true
//        mainTableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupConstraint(){
        
        self.contentView.addSubview(mainTableView)
        
        //오토레이아웃을 contentView로 잡아주니 해결! 높이 측정 불가 문제
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    
}

extension tempCell : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: "AddServiceTableViewCell", for: indexPath) as? AddServiceTableViewCell else {return UITableViewCell()}


        cell.nameLabel.text = "\(categoryList[indexPath.section][indexPath.row])"
        
//            cell.layoutIfNeeded()
            return cell
        
        
    }
 
}

extension tempCell : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return category[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

extension tempCell {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .insert
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        if editingStyle == .delete {
            print("delete")
        }
        else if editingStyle == .insert {
            print("insert")
        
            categoryList[indexPath.section].remove(at: indexPath.row)
            tableView.reloadData()
        }
       
        
    }
    
}
