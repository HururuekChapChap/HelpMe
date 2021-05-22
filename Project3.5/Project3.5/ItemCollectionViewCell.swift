//
//  ItemCollectionViewCell.swift
//  Project3.5
//
//  Created by yoon tae soo on 2021/05/22.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    let imageView : UIImageView = {
       
        let img = UIImage(named: "swift")
        let view = UIImageView(image: img)
        view.layer.cornerRadius = 60
        view.clipsToBounds = true
        view.backgroundColor = UIColor.systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let label : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.systemBlue
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraint(){
        
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: label.topAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.0)
        ])

    }
    
    func load(name : String){
        label.text = name
    }
    
}
