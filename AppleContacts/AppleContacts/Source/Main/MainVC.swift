//
//  MainVC.swift
//  AppleContacts
//
//  Created by 김혜수 on 2021/09/12.
//

import UIKit
import CoreData

class MainVC: UIViewController {
    
    var personList: Array<Person> = []
    var container: NSPersistentContainer!
  
//    let dummy = ["리정", "가비", "로잘린", "김혜수", "박씨", "선호민", "김보현", "곽민재", "이주휘", "고민영", "윤예지", "이혜선", "윤정권", "이코코", "혜임", "양요섭", "윤두준", "모니카", "립제이", "김윤서", "김루희"]
    let sectionList = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
    
    // MARK: - IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var tableheaderview: UIView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableview()
        readData()
        print("view DidLoad", personList)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTV), name: Notification.Name("save"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        tableview.reloadData()
    }
    
    func readData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        /// 가져오기
        personList = []
        do {
            let contact = try self.container.viewContext.fetch(Contact.fetchRequest()) as! [Contact]
            
            for i in contact {
                personList.append(contentsOf: [Person(name: i.name, job: i.phone, phone: i.job)])
            }
            
            print(personList)
            tableview.reloadData()
            
        } catch {
            print(error.localizedDescription)
           
        }
    }
    
    // MARK: - UI
    func setUI(){
        setSearchBarUI()
        setNavigationBarUI()
    }
    
    // MARK: UI / NavigationBar
    func setNavigationBarUI(){
        navigationController?.navigationBar.backgroundColor = .systemGray6
       
        /// 선 없애기
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

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
        tableview.tableHeaderView = tableheaderview
    }
    
    // MARK: - Objc
    @objc func refreshTV(){
        readData()
    }
    
    // MARK: - IBAction
    @IBAction func addButtonClicked(_ sender: Any) {
        guard let addVC = UIStoryboard(name: "AddContact", bundle: nil).instantiateViewController(withIdentifier: "AddContactVC") as? AddContactVC else { return }
        addVC.naviTitle = "새로운 연락처"
        self.present(addVC, animated: true, completion: nil)
    }
    
    @IBAction func groupButtonClicked(_ sender: Any) {
        guard let groupVC = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "GroupVC") as? GroupVC else { return }
        self.present(groupVC, animated: true, completion: nil)
    }
    
}

extension MainVC: UITableViewDelegate {
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionList
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else { return }
        var index = 0
        for i in 0..<indexPath.section {
            index += tableview.numberOfRows(inSection: i)
        }
        
        detailVC.person = personList.sorted(by: { $0.name < $1.name })[index + indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0 ... sectionList.count:
            return personList.filter({sectionCheck(name: $0.name) == sectionList[section]}).count
        default:
            return 0
        }
    
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionList[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0 ... sectionList.count:
            if personList.filter({sectionCheck(name: $0.name) == sectionList[section]}).count == 0 {
                return 0
            }
            else {
                return 30
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sortedList = personList.sorted(by: { $0.name < $1.name })
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainNameTVC.identifier, for: indexPath) as? MainNameTVC else {
            return UITableViewCell()
        }
        
        cell.setData(name: sortedList.filter({sectionCheck(name: $0.name) == sectionList[indexPath.section]})[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

}

extension MainVC {
    
    /// 가장 첫 초성 추출
    func sectionCheck(name: String) -> String {
        if name == "" {
            return "ㅎ"
        }
        let hangul = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
        let octal = name.unicodeScalars[name.unicodeScalars.startIndex].value
        let index = (octal - 0xac00) / 28 / 21
        return hangul[Int(index)] }
}


