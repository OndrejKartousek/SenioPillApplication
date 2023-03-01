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

class DashboardViewController : UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return daysInWeek.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return daysInWeek[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = daysInWeek[row]
    }
    
    var pickerTextField = UITextField()
     
    let daysInWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
     
     
    public var completeDataSource = CompleteList.completeModel
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
        if(completeDataSource.getAllData().isEmpty == true){
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
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
            headerView.backgroundColor = .white
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        pickerTextField.adjustsFontSizeToFitWidth = true
        pickerTextField.text = "Monday"
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
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().inset(-15)
        }
        return headerView
    }
    
    open override func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return completeDataSource.getAllData().count
    }
    
    open override func tableView(_ tableView : UITableView, cellForRowAt IndexPath : IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DashboardListTVCell.description(), for: IndexPath) as? DashboardListTVCell
        else{
            return UITableViewCell()
        }
        cell.data = completeDataSource.getAllData()[IndexPath.row]
        return cell
    }
    
    open override func tableView(_ tableView : UITableView, didSelectRowAt indexPath : IndexPath){
    }
    
    open override func tableView(_ tableView: UITableView, canEditRowAt indexPath : IndexPath) -> Bool{
        return true
    }
    
    
    
    open override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let id = completeDataSource.getDataAtIndex(index: indexPath[1]).ID
            print(("ID : \(id)"))
            completeDataSource.deleteData(index: indexPath[1])
            deleteData(id: id)
            updateData()
        }
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
                        
                        if(addedByUser == self.currentUser!){
                            let givenHour = data["Given_Hour"] as? Int ?? 1
                            let givenMinute = data["Given_Minute"] as? Int ?? 1
                            let newObj = AssignedModel(ID: document.documentID, creatorID: self.currentUser!, description: "", patientID: patientID, patientName: name, patientSurname: "", patientRoom: room, patientBed: bed, patientInfo: "", Gender: gender, addedByUser: addedByUser, drugID: drugID, drugName: drugName, drugDescription: "", drugPrescriptedDosage: "", givenDrugDosage: drugDosage, givenDrugHour: givenHour ?? 12, givenDrugMinute: givenMinute ?? 10, givenOnMonday: true, givenOnTuesday: true, givenOnWednesday: true, givenOnThursday: true, givenOnFriday: true, givenOnSaturday: true, givenOnSunday: true)
                            self.completeDataSource.addData(data: newObj)
                            
                        }
                        
                    }
                }
                self.updateData()
            }
        }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    }
