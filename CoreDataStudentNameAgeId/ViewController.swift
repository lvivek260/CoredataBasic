//
//  ViewController.swift
//  CoreDataStudentNameAgeId
//
//  Created by Admin on 01/03/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var studnetTableView: UITableView!
    var allStudentData = [StudentData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studnetTableView.delegate = self
        studnetTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        self.getAlldata()
        studnetTableView.reloadData()
    }

    @IBAction func addStudent(_ sender: UIBarButtonItem) {
        let addStudentVC = storyboard?.instantiateViewController(withIdentifier: "AddStudentViewController") as! AddStudentViewController
        self.navigationController?.pushViewController(addStudentVC, animated: true)
    }
    
    func getAlldata(){
        allStudentData = DataBaseHandler().fetchData()
        studnetTableView.reloadData()
    }
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStudentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = studnetTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let obj = allStudentData[indexPath.row]
        cell.textLabel?.text = obj.firstName! + " " + obj.lastName!
        cell.detailTextLabel?.text = String(obj.rollNumber)
        return cell
    }
}


extension ViewController:UITableViewDelegate{
    //for delete butoon add and perform using below two method
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            self.allStudentData = DataBaseHandler().deleteRecord(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    //for edit button
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit"){
            (action, swipeButtonView, completion) in
            print("edit Button Click")
            let editVC = self.storyboard?.instantiateViewController(withIdentifier: "AddStudentViewController") as! AddStudentViewController
            let obj = self.allStudentData[indexPath.row]
            editVC.studentFirstName = obj.firstName
            editVC.studentLastName = obj.lastName
            editVC.studentRollNumer = Int(obj.rollNumber)
            editVC.isEditingRecord = true
            editVC.oldObj = obj
            self.navigationController?.pushViewController(editVC, animated: true)
        }
        edit.image = #imageLiteral(resourceName: "editAfter")
                            
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [edit])
        return swipeConfiguration
    }
}
