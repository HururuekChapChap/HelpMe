//
//  MainCollectionViewCell.swift
//  Project3.5
//
//  Created by yoon tae soo on 2021/05/22.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    let mainCollectionView : UICollectionView = {
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        
        let clv = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        clv.translatesAutoresizingMaskIntoConstraints = false
        clv.backgroundColor = UIColor.systemGreen
        return clv
        
    }()
    
    let topBarView : UIView = {
       
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemPink
        return view
    }()
    
    lazy var label : UIButton = {
        let label = UIButton()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setTitle("바로가기 >", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        label.setTitleColor(UIColor.black, for: .normal)
        label.titleLabel?.textAlignment = .center
        //https://stackoverflow.com/questions/2765024/how-to-set-the-title-of-uibutton-as-left-alignment
        label.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        label.contentHorizontalAlignment = .left
        label.addTarget(self, action: #selector(shortcutBtn), for: .touchUpInside)
        return label
    }()
    
    var callBack : ((Bool)->())?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.brown
        setContraint()
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        
        mainCollectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    let items : [ String ] = ["A" ,"B" ,"C" ,"D", "E", "F","G"]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContraint(){
        
        contentView.addSubview(topBarView)

        NSLayoutConstraint.activate([

            topBarView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topBarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topBarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topBarView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        topBarView.addSubview(label)
        
        NSLayoutConstraint.activate([

            label.topAnchor.constraint(equalTo: topBarView.topAnchor),
            label.leadingAnchor.constraint(equalTo: topBarView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: topBarView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: topBarView.bottomAnchor)
            
        ])
        
        //CollectionView의 높이는 160으로 잡힘
        contentView.addSubview(mainCollectionView)

        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: topBarView.bottomAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

    }
    
    @objc func shortcutBtn(){
        print("바로가기 클릭")
        callBack?(true)
    }
    
}

extension MainCollectionViewCell : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == items.count{
                print("추가하기 클릭")
            
            callBack?(false)
        }
        
    }
    
    
}

extension MainCollectionViewCell : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ItemCollectionViewCell else {return UICollectionViewCell()}
        
        print(indexPath.row , items.count)
        
        if indexPath.row == items.count{
            cell.load(name: "추가하기")
        }
        else{
            cell.load(name: items[indexPath.item])
        }
 
        return cell
    }
    
    
}

extension MainCollectionViewCell : UICollectionViewDelegateFlowLayout{
 
    //UIEdgeInset을 다 포함해서 최종 사이즈 크기 => 실제로 반영되는 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 150)
    }
    
    //UIEdgeInset
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    
}
