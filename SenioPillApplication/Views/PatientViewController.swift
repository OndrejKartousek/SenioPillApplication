//
//  ViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 15.06.2022.
//

import SnapKit
import Foundation
import UIKit
import FirebaseFirestore
import SwiftUI
import FirebaseAuth

class PatientViewController: UITableViewController {
    
    let currentUser = Auth.auth().currentUser?.uid

    public var dataSource = PatientList()
    static var isEmpty:Bool = true
    public var noDataLabel = UILabel()
    
    let x = ""
    let z = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        getPatients()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        updateData()
        print(PatientViewController.isEmpty)
    }
    
    func updateData(){
        tableView.reloadData()
        noDataLabel.isHidden = !dataSource.getPatients().isEmpty
        }
    
    
    open func prepareView(){
        view.backgroundColor = .white
        self.title = "Patients"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        prepareTableView()
        prepareNoPatientsLabel()
    }
    
    func prepareTableView() {
        tableView.register(PatientListTVCell.self, forCellReuseIdentifier: PatientListTVCell.description())
        tableView.rowHeight = 120
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = blueColor
        print("xy")
    }
    
    func prepareNoPatientsLabel(){
        noDataLabel.isHidden = true
        noDataLabel.text = "No patients added yet."
        tableView.addSubview(noDataLabel)
        noDataLabel.snp.makeConstraints{make in
            make.center.equalToSuperview()
        }
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
        return dataSource.getPatients().count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PatientListTVCell.description(), for: indexPath) as? PatientListTVCell else {
            return UITableViewCell()
        }
        cell.data = dataSource.getPatients()[indexPath.row]
        return cell
    }
    
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PatientProfileViewController(dataSource: dataSource)
        vc.data = dataSource.getPatients()[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    open override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
    open override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataSource.deletePatient(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            noDataLabel.isHidden = !dataSource.getPatients().isEmpty
        }
    }
    
    @objc func addTapped() {
        let vc = AddPatientViewController(dataSource: dataSource)
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.reloadData()
        PatientViewController.isEmpty = false
        print(PatientViewController.isEmpty)
    }
    
    func addClickedProfile(){
        let vc = PatientProfileViewController(dataSource: dataSource)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    public func getPatients(){
        let db = Firestore.firestore();
        let ref = db.collection("Patients");
        
        let dbb = Firestore.firestore()
        dbb.collection("Drugs").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    print(document.documentID)
                    print(document.data())
                }
            }
        }
        
        ref.getDocuments{snapshot, error in
                         guard error == nil else {
            print(error!.localizedDescription)
            return
        }
            if let snapshot = snapshot {
                for document in snapshot.documents{
                    let data = document.data()
                    print(document.documentID)
                    let patientName = data["name"] as? String ?? ""
                    let patientSurname = data["surname"] as? String ?? ""
                    let room = data["room"] as? String ?? ""
                    let bed = data["bed"] as? String ?? ""
                    let gender = data["gender"] as? String ?? ""
                    let patientInfo = data["patient_info"] as? String ?? ""
                    let addedByUser = data["added_by_user"] as? String ?? ""
                    if(addedByUser == self.currentUser!){
                        let PatientNew = Patient(name: patientName, surname: patientSurname, room: room, bed: bed, patientInfo: patientInfo, Gender: gender, addedByUser: self.currentUser!, assignedDrugs: [self.x,self.z], ID: document.documentID)
                        self.dataSource.addPatient(patient: PatientNew)
                    }
                }
            }
        }
    }
    
    
}





