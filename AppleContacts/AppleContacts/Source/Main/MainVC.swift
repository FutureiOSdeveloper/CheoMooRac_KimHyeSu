//
//  MainVC.swift
//  AppleContacts
//
//  Created by 김혜수 on 2021/09/12.
//

import UIKit

class MainVC: UIViewController {
    
    let dummy = ["리정", "가비", "로잘린"]
    
    // MARK: - IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableview()
    }
    
    // MARK: - UI
    func setUI(){
        setSearchBarUI()
    }
    
    // MARK: UI / SearchBarUI
    func setSearchBarUI(){
        searchBar.barTintColor = .systemGray6
        searchBar.layer.borderColor = UIColor.systemGray6.cgColor
    }
    
    // MARK: - setTableView
    func setTableview(){
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    // MARK: - IBAction
    @IBAction func addButtonClicked(_ sender: Any) {
        guard let addVC = UIStoryboard(name: "AddContact", bundle: nil).instantiateViewController(withIdentifier: "AddContactVC") as? AddContactVC else { return }
        self.present(addVC, animated: true, completion: nil)
    }
    
    @IBAction func groupButtonClicked(_ sender: Any) {
        guard let groupVC = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "GroupVC") as? GroupVC else { return }
        self.present(groupVC, animated: true, completion: nil)
    }
    
}

extension MainVC: UITableViewDelegate {
    
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainNameTVC.identifier, for: indexPath) as? MainNameTVC else {
            return UITableViewCell()
        }
        cell.setData(name: dummy[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

}
