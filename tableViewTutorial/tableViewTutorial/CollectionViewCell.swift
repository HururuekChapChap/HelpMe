//
//  CollectionViewCell.swift
//  tableViewTutorial
//
//  Created by yoon tae soo on 2021/05/15.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var testView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        let width = self.contentView.bounds.width
        print("widht : \(width)")
    }
    
    func updateCell(data : ShortCutModel){
        
//        self.imageView.image = data.image
        self.nameLabel.text = data.name
        
//        testView.layer.cornerRadius = self.testView.frame.size.width / 2
//        testView.clipsToBounds = true
        testView.backgroundColor = UIColor.gray
        
    }
    
//    override func layoutSubviews() {
//           super.layoutSubviews()
//
//           self.testView.layer.masksToBounds = true
//           self.testView.layer.cornerRadius = CGFloat(roundf(Float(self.testView.frame.size.width/2.0)))
//       }

}
