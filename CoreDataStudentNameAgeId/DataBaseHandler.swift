//
//  DataBaseHandler.swift
//  CoreDataStudentNameAgeId
//
//  Created by Admin on 01/03/23.
//

import Foundation
import UIKit
import CoreData

class DataBaseHandler{
    var context = ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
    
    
    func saveData(firstName:String, lastName:String, rollNumber:Int64){
        let studentDataObject = NSEntityDescription.insertNewObject(forEntityName: "StudentData", into: context) as! StudentData
        
        studentDataObject.firstName = firstName
        studentDataObject.lastName = lastName
        studentDataObject.rollNumber = rollNumber
        do{
             try context.save()
            print("student Data Sucessfully saved")
        }
        catch{
            print("student Data Saving Error")
        }
    }
    
    func fetchData()->[StudentData]{
        var data=[StudentData]()
        
        do{
            data = try context.fetch(StudentData.fetchRequest()) as! [StudentData]
            print("Data sucessfully fetched")
        }
        catch{
            print("error occured during Fetching data")
        }
        return data
    }
    
    func updateStudentRecord(oldObject:StudentData,firstName:String, lastName:String, rollNumber:Int64){
        oldObject.firstName = firstName
        oldObject.lastName = lastName
        oldObject.rollNumber = rollNumber
        do{
            try context.save()
        }catch{}
    }
    
    func deleteRecord(index:Int)->[StudentData]{
        var allStudentData = self.fetchData()

        context.delete(allStudentData[index])
        allStudentData.remove(at: index)
        do{
            try context.save()
            print("data deleted")
        }
        catch{
            print("Data Not deleted")
        }
        return allStudentData
    }
    
}
