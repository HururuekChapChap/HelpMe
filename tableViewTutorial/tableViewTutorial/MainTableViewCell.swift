//
//  MainTableViewCell.swift
//  tableViewTutorial
//
//  Created by yoon tae soo on 2021/05/15.
//

import UIKit

struct ShortCutModel{
    
    let name : String
    let image : UIImage
    
}

class SingletonManager {
    
    static var shared = SingletonManager()
    
    var items : [ShortCutModel] = [
        ShortCutModel(name: "추가하기", image: UIImage(named: "swift")!)
    ]
    
}


class MainTableViewCell: UITableViewCell {

    @IBOutlet var titleView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    let manager = SingletonManager.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleView.backgroundColor = UIColor.systemPink
    
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func settingCollectionView(){
        
    }
    
}

extension MainTableViewCell : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectoin selected : \(indexPath.item)")
    }
    
    
}

extension MainTableViewCell : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CollectionViewCell else {return UICollectionViewCell()}
        
        let item = manager.items[indexPath.item]
        
        cell.updateCell(data: item)
        
        if indexPath.item % 2 == 0 {
            cell.mainView.backgroundColor = UIColor.systemBlue
        }
        else{
            cell.mainView.backgroundColor = UIColor.systemGreen
        }
        
        return cell
    }
        
}

extension MainTableViewCell : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 150, height: 200)
    }
    
}
