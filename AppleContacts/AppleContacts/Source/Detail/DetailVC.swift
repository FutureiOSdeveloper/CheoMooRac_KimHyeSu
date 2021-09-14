//
//  DetailVC.swift
//  AppleContacts
//
//  Created by 김혜수 on 2021/09/14.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableview()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - setTableview
    func setTableview(){
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    


}

extension DetailVC: UITableViewDelegate {
    
}

extension DetailVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1, 4, 2:
            return 1
        case 3:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailNumberTVC.identifier) as? DetailNumberTVC else { return UITableViewCell()}
            return cell
        
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailFacetimeTVC.identifier) as? DetailFacetimeTVC else { return UITableViewCell()}
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailMemoTVC.identifier) as? DetailMemoTVC else { return UITableViewCell() }
            return cell
            
        case 3:
            let data = ["메시지 보내기", "연락처 공유", "즐겨찾기에 추가"]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailButtonTVC.identifier) as? DetailButtonTVC else { return UITableViewCell() }
            cell.setData(title: data[indexPath.row])
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailButtonTVC.identifier) as? DetailButtonTVC else { return UITableViewCell() }
            cell.setData(title: "긴급 연락처에 추가")
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0,1:
            return 60
        case 2:
            return 70
        case 3,4 :
            return 40
        default:
            return 100
        }
    }
    
}
