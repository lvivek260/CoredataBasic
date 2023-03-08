//
//  AddStudentViewController.swift
//  CoreDataStudentNameAgeId
//
//  Created by Admin on 01/03/23.
//

import UIKit
import CoreData

class AddStudentViewController: UIViewController {
    let context = DataBaseHandler().context
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var warningError: UILabel!
    
    var studentFirstName:String?
    var studentLastName:String?
    var studentRollNumer:Int?
    var oldObj:StudentData?
    var isEditingRecord:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warningError.isHidden = true
        setDataOnTextField()
    }
    func setDataOnTextField(){
        if(isEditingRecord){
            firstName.text = studentFirstName
            lastName.text = studentLastName
            id.text = String(studentRollNumer!)
        }
    }
    @IBAction func saveButtonClick(_ sender: UIButton) {
        if(firstName.text!.isEmpty || lastName.text!.isEmpty || id.text!.isEmpty ){
            warningError.isHidden = false
        }
        else{
            warningError.isHidden = true
            if(isEditingRecord){
                DataBaseHandler().updateStudentRecord(oldObject: oldObj!, firstName: firstName.text!, lastName: lastName.text!, rollNumber: Int64(id.text!)!)
                self.navigationController?.popViewController(animated: true)
            }
            else{
                let firstName = firstName.text!
                let lastName = lastName.text!
                let id = Int(id.text!)!
                
                DataBaseHandler().saveData(firstName: firstName, lastName: lastName,rollNumber: Int64(id))
                print("save button Click")
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
