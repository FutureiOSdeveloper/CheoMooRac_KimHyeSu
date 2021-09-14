//
//  DetailTopCVC.swift
//  AppleContacts
//
//  Created by 김혜수 on 2021/09/14.
//

import UIKit

class DetailTopCVC: UICollectionViewCell {
    
    public static let identifier = "DetailTopCVC"
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        view.layer.cornerRadius = 7
    }
    
    func setData(title: String, index: Int){
        label.text = title
        switch index {
        case 0:
            imgview.image = UIImage(systemName: "message.fill")
        case 1:
            imgview.image = UIImage(systemName: "phone.fill")
        case 2:
            imgview.image = UIImage(systemName: "video.fill")
        case 3:
            imgview.image = UIImage(systemName: "envelope.fill")
            
        default:
            imgview.image = UIImage(systemName: "envelope.fill")
        }
    }
    
    
}
