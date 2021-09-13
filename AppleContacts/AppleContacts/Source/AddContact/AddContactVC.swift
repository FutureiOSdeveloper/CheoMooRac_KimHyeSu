//
//  AddContactVC.swift
//  AppleContacts
//
//  Created by 김혜수 on 2021/09/12.
//

import UIKit

class AddContactVC: UIViewController {
    
    let inputPlaceholder = ["성", "이름", "직장", "연락처"]

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableview()
        // Do any additional setup after loading the view.
    }
   
    // MARK: - Set TableView
    func setTableview(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = .systemGray6
    }
    
    // MARK: - IBAction
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddContactVC: UITableViewDelegate {
    
}

extension AddContactVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddPhotoTVC.identifier, for: indexPath) as? AddPhotoTVC else { return UITableViewCell() }
            return cell
            
        case 1...4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddInputTVC.identifier, for: indexPath) as? AddInputTVC else { return UITableViewCell() }
            cell.setData(placeholder: inputPlaceholder[indexPath.row-1])
            return cell
        default:
            return UITableViewCell()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 170
        default:
            return 40
        }
    }
}
