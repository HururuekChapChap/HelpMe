//
//  CodeBaseViewController.swift
//  TableInTable
//
//  Created by Michał Kaczmarek on 26.09.2017.
//  Copyright © 2017 Michał Kaczmarek. All rights reserved.
//

import UIKit

class CodeBaseViewController: UIViewController {
    
    let tableView: OwnTableView = OwnTableView()
    let cellId = "firstTableCellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tableView.reloadData()
        view.backgroundColor = UIColor.gray
    }
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(NextTable.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor.green
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        #if false
        
        view.addConstraintsWithFormat("V:|-60-[v0]-5-|", views: tableView)
        view.addConstraintsWithFormat("H:|-8-[v0]-8-|", views: tableView)
        
        tableView.beginUpdates()
        tableView.reloadData()
        tableView.endUpdates()
        
        #endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
}

extension CodeBaseViewController: UITableViewDelegate {
    
}

extension CodeBaseViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NextTable
        return cell
    }
}
