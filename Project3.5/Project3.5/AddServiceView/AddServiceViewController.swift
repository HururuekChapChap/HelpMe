//
//  AddServiceViewController.swift
//  Project3.5
//
//  Created by yoon tae soo on 2021/05/22.
//

import UIKit

//https://magi82.github.io/ios-intrinsicContentSize/
//https://stackoverflow.com/questions/46441711/uitableview-inside-uitableviewcell-with-dynamic-height
class OwnTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    
    override var contentSize: CGSize {
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }
}

class AddServiceViewController: UIViewController {

    let mainTableView : UITableView = {
        
//        let tbv = OwnTableView()
        let tbv = UITableView()
        tbv.translatesAutoresizingMaskIntoConstraints = false
        tbv.backgroundColor = UIColor.yellow
        return tbv
        
    }()
    
    lazy var categoryList : [String] = [
        "추가된 서비스 (\(myList.count))",
        "추가할 수 있는 서비스"
    ]
    
    var myList : [String] = [
        "Hello world",
        "My Item",
        "Show",
        "Me",
        "The",
        "Money"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mainTableView.register(UINib(nibName: "AddServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "AddServiceTableViewCell")
        
//        mainTableView.register(NextTable.self, forCellReuseIdentifier: "tempCell")
        
        mainTableView.register(tempCell.self, forCellReuseIdentifier: "tempCell")
        setContraint()
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        
        mainTableView.isEditing = true
        
//        mainTableView.tableFooterView = UIView()
        
//        mainTableView.beginUpdates()
//        mainTableView.reloadData()
//        mainTableView.endUpdates()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mainTableView.reloadData() //View 구성을 다 마쳤을 때 테이블 재 로드 해서 불필요한 여백 제거
    }
    
    func setContraint(){
        
        self.view.addSubview(mainTableView)
        
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    

}

extension AddServiceViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return myList.count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
        
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: "AddServiceTableViewCell", for: indexPath) as? AddServiceTableViewCell else {return UITableViewCell()}
        
            
            cell.nameLabel.text = myList[indexPath.row]
            
            return cell
        }
        
//        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: "tempCell", for: indexPath) as? NextTable else {return UITableViewCell()}
        
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: "tempCell", for: indexPath) as? tempCell else {return UITableViewCell()}
        
        cell.backgroundColor = UIColor.clear //여백 보여주는 것을 제거하기 위해 사용
        
        return cell
        
    }
    
    //이걸 해줘야 shouldIndentWhileEditingRowAt의 여백 지우는 것을 할 수 있다.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return indexPath.section == 0 ? true : false
        
    }
    
    //이걸 해줘야 delete 버튼을 누를 때 delete 버튼이 나온다.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){

        if editingStyle == .delete {
            print("delete")
        }
        else if editingStyle == .insert {
            print("insert")
        }
        else{
            print("None")
        }

    }
}

extension AddServiceViewController : UITableViewDelegate{
    
    //편집 스타일을 어떤 걸로 정해주는 부분이다.
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return indexPath.section == 0 ? .delete : .none
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categoryList[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return UITableView.automaticDimension
//    }

    //이동이 가능하게 만들어 주는 코드이다.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    
        return indexPath.section == 0 ? true : false
    }
    
    //이동을 했을 때 어떤 작업을 수행 할지 정하는 코드 이다.
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if destinationIndexPath.section != 0 {return}
        myList.swapAt(sourceIndexPath.row, destinationIndexPath.row)
//        print(sourceIndexPath , destinationIndexPath)
    }
    
    //여백의 존재 여부를 판단해주는 것이다. YES 일때 여백을 없애 준다.
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //다른 섹션으로 이동하는거 방지 코드
    //https://stackoverflow.com/questions/849926/how-to-limit-uitableview-row-reordering-to-a-section
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        
        print(sourceIndexPath , proposedDestinationIndexPath)
        
        if sourceIndexPath.section != proposedDestinationIndexPath.section {
            print("서로 다른 섹션")
            return sourceIndexPath
        }
        
        print("서로 같은 섹션")
        return proposedDestinationIndexPath
        
    }

}
