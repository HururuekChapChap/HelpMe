//
//  AllServiceTableViewCell.swift
//  Project3.5
//
//  Created by yoon tae soo on 2021/05/22.
//

import UIKit

class AllServiceTableViewCell: UITableViewCell {

    @IBOutlet var serviceImageView: UIImageView!
    @IBOutlet var motherLabel: UILabel!
    @IBOutlet var childLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //https://stackoverflow.com/questions/43395085/how-to-change-uibutton-state-programmatically-in-swift
        favoriteButton.setTitle("Hello", for: .normal)
        favoriteButton.setTitle("", for: .selected)
        favoriteButton.setImage(UIImage(named: "swift"), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoritBtnAction(_ sender: UIButton) {
        
        favoriteButton.isSelected = !favoriteButton.isSelected
        
    }
    
    func updateUI(image : String , mother : String , child : String, state : Bool){
        
        serviceImageView.image = UIImage(named: "swift")
        motherLabel.text = mother
        childLabel.text = child
        favoriteButton.isSelected = state
        
    }
}
