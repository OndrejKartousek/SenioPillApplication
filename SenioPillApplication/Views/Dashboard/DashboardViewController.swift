//
//  DashboardViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 17.06.2022.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct dayInPicker {
    var title: String
    var date: Date
}
let today = Date()
var calendar = Calendar.current
let midnight = calendar.startOfDay(for: today)

let greenColor = UIColor(red: 64, green: 227, blue: 32)


class DashboardViewController : UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    let dateFormatter = DateFormatter()
    var displayingToday = true;
    var daysInWeek: [dayInPicker] = []

    
    init() {
      
        super.init(nibName: nil, bundle: nil)
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "en-US")
        self.daysInWeek = [
            dayInPicker(title: "Today", date: today),
            dayInPicker(title: dateFormatter.string(from: calendar.date(byAdding: .day, value: 1, to: today)!), date: calendar.date(byAdding: .day, value: 1, to: today)!),
            dayInPicker(title: dateFormatter.string(from: calendar.date(byAdding: .day, value: 2, to: today)!), date: calendar.date(byAdding: .day, value: 2, to: today)!),
            dayInPicker(title: dateFormatter.string(from: calendar.date(byAdding: .day, value: 3, to: today)!), date: calendar.date(byAdding: .day, value: 3, to: today)!),
            dayInPicker(title: dateFormatter.string(from: calendar.date(byAdding: .day, value: 4, to: today)!), date: calendar.date(byAdding: .day, value: 4, to: today)!),
            dayInPicker(title: dateFormatter.string(from: calendar.date(byAdding: .day, value: 5, to: today)!), date: calendar.date(byAdding: .day, value: 5, to: today)!),
            dayInPicker(title: dateFormatter.string(from: calendar.date(byAdding: .day, value: 6, to: today)!), date: calendar.date(byAdding: .day, value: 6, to: today)!),
        ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return daysInWeek.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        return daysInWeek[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.displayingToday = daysInWeek[row].title == "Today"
    
        filterAssigments(date: daysInWeek[row].date, title: daysInWeek[row].title)
        pickerTextField.text = daysInWeek[row].title
    }
    
    var pickerTextField = UITextField()
     
  
     
     
    public var completeDataSource = CompleteList.completeModel
    public var displayAssignments: [AssignedModel] = []
    public static var isEmpty:Bool = true
    let headerImageView = UIImageView()
    public var noDataLabel = UILabel()
    
    let currentUser = Auth.auth().currentUser?.uid

    private let dayPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int { return 1 }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        updateData()
        getAllData()
        noDataLabel.isEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        filterAssigments(date: Date(), title: "Today")
        updateData()
    }
    
    open func prepareView(){
        view.backgroundColor = .white
        self.title = "Dashboard"
        prepareTableView()
        prepareNoDataLabel()
        
    }
    
    func updateData(){
        tableView.reloadData()
        if(displayAssignments.isEmpty == true){
            noDataLabel.isEnabled = true
            noDataLabel.isHidden = false
        }else{
            noDataLabel.isEnabled = false
            noDataLabel.isHidden = true
        }
    }
    
    func prepareTableView(){
        tableView.register(DashboardListTVCell.self, forCellReuseIdentifier: DashboardListTVCell.description())
        tableView.rowHeight = 200
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = blueColor
    }
    
    func prepareNoDataLabel(){
        noDataLabel.isHidden = true
        noDataLabel.text = "No data added yet."
        tableView.addSubview(noDataLabel)
        noDataLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect.init(x: 100, y: 0, width: 100, height: 0))
            headerView.backgroundColor = .clear
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        pickerTextField.adjustsFontSizeToFitWidth = true
        pickerTextField.text = "Today"
        pickerTextField.textAlignment = .center
        pickerTextField.inputView = pickerView
        pickerTextField.borderStyle = .roundedRect
        pickerTextField.layer.cornerRadius = pickerTextField.bounds.height / 2.0
        pickerTextField.layer.masksToBounds = true
        pickerTextField.textColor = .white
        pickerTextField.font = UIFont.boldSystemFont(ofSize: 20)
        pickerTextField.backgroundColor = blueColor
        pickerTextField.layer.borderColor = blueColor.cgColor
        pickerTextField.layer.borderWidth = 1
        pickerTextField.allowsEditingTextAttributes = false
        headerView.addSubview(pickerTextField)
        pickerTextField.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(15)
        }
        return headerView
    }
    
    open override func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return displayAssignments.count
    }
    
    open override func tableView(_ tableView : UITableView, cellForRowAt IndexPath : IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DashboardListTVCell.description(), for: IndexPath) as? DashboardListTVCell
        else{
            return UITableViewCell()
        }
        if(displayingToday && Calendar.current.component(.day, from: Date()) == Calendar.current.component(.day, from:displayAssignments[IndexPath.row].nextDateToGive)){
            if(Calendar.current.component(.hour, from: Date()) > displayAssignments[IndexPath.row].givenDrugHour){
                cell.backgroundColor = .systemRed
                cell.prepareAlert()

            }else if(Calendar.current.component(.hour, from: Date()) == displayAssignments[IndexPath.row].givenDrugHour && Calendar.current.component(.minute, from: Date()) > displayAssignments[IndexPath.row].givenDrugMinute){
                cell.backgroundColor = .systemRed
            }
        }else {
            cell.backgroundColor = .white
        }
        cell.data = displayAssignments[IndexPath.row]
        return cell
    }
    
    open override func tableView(_ tableView : UITableView, didSelectRowAt indexPath : IndexPath){
    }
    
    open override func tableView(_ tableView: UITableView, canEditRowAt indexPath : IndexPath) -> Bool{
        return true
    }
    
    
    
    open override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let id = displayAssignments[indexPath[1]].ID
            print(("ID : \(id)"))
            completeDataSource.deleteById(id: id)
            displayAssignments.remove(at: indexPath[1])
            deleteData(id: id)
            updateData()
        }
    }
    
    open override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         let modifyAction = UIContextualAction(style: .normal, title:  "Update", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
             
             if(!self.displayingToday){return;}
             let id = self.displayAssignments[indexPath[1]].ID
             self.completeDataSource.updateData(id: id)
                                                                                                        
             self.filterAssigments(date: Date(), title: "Today")
             self.updateData()
             success(true)
         })
        if(!self.displayingToday){return nil;}
         modifyAction.image = UIImage(named: "hammer")
         modifyAction.backgroundColor = greenColor
        
         return UISwipeActionsConfiguration(actions: [modifyAction])
     }
    
    func deleteData(id : String){
        let db = Firestore.firestore()
        db.collection("AssignedDrugs").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func filterAssigments(date:Date, title:String){
        displayAssignments = []
        let formatter1 = DateFormatter()
        let formatter2 = DateFormatter()
        formatter1.dateFormat = "d"
        formatter2.dateFormat = "d"
     
     
        for ass in completeDataSource.getAllData(){
            if(formatter1.string(from: date) == formatter1.string(from: ass.nextDateToGive)){
                print("tu")
                displayAssignments.append(ass)
            } else if(Int(formatter2.string(from: date))! >= Int(formatter2.string(from: ass.nextDateToGive))!){
                print("tady")
                print(title)
               
                if(title == "Sunday" && ass.givenOnSunday){
                    displayAssignments.append(ass)
                }else if(title == "Saturday" && ass.givenOnSaturday){
                    displayAssignments.append(ass)
                }else if(title == "Friday" && ass.givenOnFriday){
                    displayAssignments.append(ass)
                }else if(title == "Monday" && ass.givenOnMonday){
                    displayAssignments.append(ass)
                }else if(title == "Tuesday" && ass.givenOnTuesday){
                    displayAssignments.append(ass)
                }else if(title == "Wednesday" && ass.givenOnWednesday){
                    displayAssignments.append(ass)
                }else if(title == "Thursday" && ass.givenOnThursday){
                    displayAssignments.append(ass)
                }
            }else {
                print(Int(formatter2.string(from: date))!)
                print(Int(formatter2.string(from: ass.nextDateToGive))!)
                print(Int(formatter2.string(from: date))! > Int(formatter2.string(from: ass.nextDateToGive))!)
                if(title == "Today" && Int(formatter2.string(from: date))! > Int(formatter2.string(from: ass.nextDateToGive))!){
                    displayAssignments.append(ass)
                }
            }
        }
        updateData()
    }
        
        func getAllData(){
            let db = Firestore.firestore()
            let ref = db.collection("AssignedDrugs")
            
            let dbb = Firestore.firestore()
            dbb.collection("AssignedDrugs").getDocuments{ (QuerySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else{
                }
            }
            
            ref.getDocuments{snapshot, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                if let snapshot = snapshot{
                    for document in snapshot.documents{
                        let data = document.data()
                        print(data)
                        let patientName = data["Patient_Name"] as? String ?? ""
                        let patientSurname = data["Patient_Surname"] as? String ?? ""
                        let name = patientName + " " + patientSurname
                        let addedByUser = data["Added_By_User"] as? String ?? ""
                        let patientID = data["PatientID"] as? String ?? ""
                        let drugID = data["DataID"] as? String ?? ""
                        let drugName = data["Drug_Name"] as? String ?? ""
                        let gender = data["Patient_Gender"] as? String ?? ""
                        let room = data["Patient_Room"] as? String ?? ""
                        let bed = data["Patient_Bed"] as? String ?? ""
                        let drugDosage = data["Given_Dosage"] as? String ?? ""
                        let monday = data["Monday"] as! Bool
                        let tuesday = data["Tuesday"] as! Bool
                        let wednesday = data["Wednesday"] as! Bool
                        let thursday = data["Thursday"] as! Bool
                        let friday = data["Friday"] as! Bool
                        let saturday = data["Saturday"] as! Bool
                        let sunday = data["Sunday"] as! Bool
                        let timestamp = data["nextDateToGive"] as! Timestamp
                        
                   
                        
                        if(addedByUser == self.currentUser!){
                            let givenHour = data["Given_Hour"] as? Int ?? 1
                            let givenMinute = data["Given_Minute"] as? Int ?? 1
                            let newObj = AssignedModel(ID: document.documentID, creatorID: self.currentUser!, description: "", patientID: patientID, patientName: name, patientSurname: "", patientRoom: room, patientBed: bed, patientInfo: "", Gender: gender, addedByUser: addedByUser, drugID: drugID, drugName: drugName, drugDescription: "", drugPrescriptedDosage: "", givenDrugDosage: drugDosage, givenDrugHour: givenHour ?? 12, givenDrugMinute: givenMinute ?? 10, givenOnMonday: monday, givenOnTuesday: tuesday, givenOnWednesday: wednesday, givenOnThursday: thursday, givenOnFriday: friday, givenOnSaturday: saturday, givenOnSunday: sunday, NextDateToGive: timestamp.dateValue())
                            self.completeDataSource.addData(data: newObj)
                            
                        }
                        
                    }
                }
                self.filterAssigments(date: Date(), title:"Today")
                self.updateData()
            }
        }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    }
