//
//  MainViewController.swift
//  CV_in_TB
//
//  Created by yoon tae soo on 2021/05/16.
//

import UIKit

struct Model{
    
    let color : UIColor
    let name : String
    
}

class SingletonManager {
    
    static let shared = SingletonManager()
    
    var itemList : [Model] = [
        Model(color: UIColor.yellow, name: "추가하기")
    ]
    
}

class MainViewController: UIViewController {

    let collectionView : UICollectionView = {
        
        let flowlayOut = UICollectionViewFlowLayout()
        flowlayOut.scrollDirection = .horizontal
        
        let clv = UICollectionView(frame: .zero, collectionViewLayout: flowlayOut)
        clv.translatesAutoresizingMaskIntoConstraints = false
        return clv
        
    }()
    
    let mainview : UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.systemGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    let label : UILabel = {
       
        let label = UILabel()
        label.textAlignment = .left
        label.text = "바로가기"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let manager = SingletonManager.shared
    
    var mainViewController : ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.systemBlue
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        setCLVConstraint()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setCLVConstraint(){
        view.addSubview(mainview)
        
        NSLayoutConstraint.activate([
            mainview.topAnchor.constraint(equalTo: view.topAnchor),
            mainview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainview.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor.systemTeal
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: mainview.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
        
        mainview.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: mainview.topAnchor),
            label.leadingAnchor.constraint(equalTo: mainview.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: mainview.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: mainview.bottomAnchor)
        ])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("Finished load")
        
        collectionView.reloadData()
    }

}

extension MainViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let mainVC = mainViewController else {return}
        
        let nextVC = SecondViewController()
        mainVC.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
}

extension MainViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else {return UICollectionViewCell()}
        
        let item = manager.itemList[indexPath.item]
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.systemRed
            cell.mainView.backgroundColor = UIColor.systemPurple
        }
        else{
            cell.backgroundColor = UIColor.systemPurple
            cell.mainView.backgroundColor = UIColor.systemRed
        }
        
        print("called in Controller mainView widht : \(cell.mainView.frame.width)")
        
        cell.updateCell(data: item)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
}

extension MainViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        print("widht : \(width) , height : \(height)")
        
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    } // 전체 Cell의 왼쪽 오른쪽 위 아래 간격
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    } // Cell 사이의 간격
    
}
