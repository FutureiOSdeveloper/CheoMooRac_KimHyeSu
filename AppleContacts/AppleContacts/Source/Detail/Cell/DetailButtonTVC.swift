//
//  DetailButtonTVC.swift
//  AppleContacts
//
//  Created by 김혜수 on 2021/09/14.
//

import UIKit

class DetailButtonTVC: UITableViewCell {
    
    public static let identifier = "DetailButtonTVC"

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(title: String){
        label.text = title
    }

}
