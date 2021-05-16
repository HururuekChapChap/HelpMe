//
//  MainCollectionViewCell.swift
//  CV_in_TB
//
//  Created by yoon tae soo on 2021/05/16.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet var mainView: UIView!
    @IBOutlet var nameLabel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        print("mainView widht:\(mainView.frame.width) height : \(mainView.frame.height)")
        
    }
    
    func updateCell(data : Model){
        
        nameLabel.setTitle(data.name, for: .normal)
        mainView.layer.cornerRadius = mainView.frame.width / 2
        mainView.backgroundColor = data.color
        
    }
    
    @IBAction func clickBtn(_ sender: UIButton) {
        print("Clicked")
    }
    
}
