//
//  AddInputTVC.swift
//  AppleContacts
//
//  Created by κΉνμ on 2021/09/13.
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

    func setData(placeholder: String, edit: String){
        inputTextField.placeholder = placeholder
        inputTextField.text = edit
    }

}
