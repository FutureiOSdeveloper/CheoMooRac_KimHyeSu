//
//  GroupVC.swift
//  AppleContacts
//
//  Created by 김혜수 on 2021/09/13.
//

import UIKit

class GroupVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var headerview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableview()
    }
    
    func setTableview(){
        tableview.delegate = self
        tableview.dataSource = self
        headerview.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40)
        tableview.tableHeaderView = headerview
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension GroupVC: UITableViewDelegate {
    
}

extension GroupVC: UITableViewDataSource {
    
    /// 나중엔 그룹 이름 배열로 들어가야 할듯
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "IClOUD"
        default:
            return "section이름"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupTVC.identifier, for: indexPath) as? GroupTVC else { return UITableViewCell() }
        return cell
    }
    
    
}
