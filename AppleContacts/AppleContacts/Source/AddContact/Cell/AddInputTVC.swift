//
//  AddInputTVC.swift
//  AppleContacts
//
//  Created by 김혜수 on 2021/09/13.
//

import UIKit

class AddInputTVC: UITableViewCell {
    
    public static let identifier = "AddInputTVC"
    @IBOutlet weak var inputTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(placeholder: String){
        inputTextField.placeholder = placeholder
    }

}
