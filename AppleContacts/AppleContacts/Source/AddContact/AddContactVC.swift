//
//  AddContactVC.swift
//  AppleContacts
//
//  Created by 김혜수 on 2021/09/12.
//

import UIKit
import CoreData

class AddContactVC: UIViewController {
    
    var container: NSPersistentContainer!
    let inputPlaceholder = ["이름", "직장", "연락처"]

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableview()
        setCD()
    }
    
    func setCD(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
        // 가져오기
        do {
            let contact = try self.container.viewContext.fetch(Contact.fetchRequest()) as! [Contact]
            contact.forEach {
                print($0.name)
                print($0.phone)
                print($0.job)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
   
    // MARK: - Set TableView
    func setTableview(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = .systemGray6
    }
    
    // MARK: - Core Data
    func saveData(name: String, phone: String, job: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: self.container.viewContext)
        let person = NSManagedObject(entity: entity!, insertInto: self.container.viewContext)
        NotificationCenter.default.post(name: NSNotification.Name("save")
                        ,object: nil)
        person.setValue(name, forKey: "name")
        person.setValue(phone, forKey: "phone")
        person.setValue(job, forKey: "job")
    }
    
    
    // MARK: - IBAction
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        /// 저장하기
        let name = tableview.cellForRow(at: IndexPath(row: 1, section: 0)) as! AddInputTVC
        let phone = tableview.cellForRow(at: IndexPath(row: 2, section: 0)) as! AddInputTVC
        let job = tableview.cellForRow(at: IndexPath(row: 3, section: 0)) as! AddInputTVC
        
        if (name.inputTextField.text! != "") || (phone.inputTextField.text! != "") || (job.inputTextField.text! != "") {
            saveData(name: name.inputTextField.text! , phone: phone.inputTextField.text!, job: job.inputTextField.text!)
            self.dismiss(animated: true) {
                // main -- tableview reload
                NotificationCenter.default.post(name: NSNotification.Name("save")
                                ,object: nil)
            }
        }
    }
}

extension AddContactVC: UITableViewDelegate {
    
}

extension AddContactVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddPhotoTVC.identifier, for: indexPath) as? AddPhotoTVC else { return UITableViewCell() }
            return cell
            
        case 1...3:
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
