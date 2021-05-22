//
//  NextTable.swift
//  TableInTable
//
//  Created by Michał Kaczmarek on 26.09.2017.
//  Copyright © 2017 Michał Kaczmarek. All rights reserved.
//

import UIKit

class NextTable: UITableViewCell {
    
    var myTableView: OwnTableView = OwnTableView()
    let cellId = "nextTableCellId"
    
    var number: Int!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.brown
        setupView()
        myTableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        myTableView.delegate = self
        myTableView.dataSource = self
//        myTableView.separatorStyle = .singleLine
        myTableView.backgroundColor = UIColor.blue
        
        #if false
        
        myTableView.register(TableCell.self, forCellReuseIdentifier: cellId)
        
        #endif
        
        #if true
        
        myTableView.register(UINib(nibName: "AddServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "AddServiceTableViewCell")
        
        #endif
        
        myTableView.isScrollEnabled = false
        addSubview(myTableView)
        
        #if false
        
        addConstraintsWithFormat("H:|-30-[v0]-30-|", views: myTableView)

        addConstraint(NSLayoutConstraint(item: myTableView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 15))
        addConstraint(NSLayoutConstraint(item: myTableView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -15))
        
        
        #endif
        
        #if true
        
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraintsWithFormat("H:|-30-[v0]-30-|", views: myTableView)

        NSLayoutConstraint.activate([
            myTableView.topAnchor.constraint(equalTo: self.topAnchor),
//            myTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            myTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            myTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        #endif
        
    }
}

extension NextTable: UITableViewDelegate {
    
}

extension NextTable: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        #if false
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableCell
        cell.setupData(number: indexPath.row)
        #endif
        
        
        #if true
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddServiceTableViewCell", for: indexPath) as! AddServiceTableViewCell
        
        cell.nameLabel.text = "row : \(indexPath.row)"
        
        #endif
        
        
        cell.layoutIfNeeded()
        return cell
    }
}
