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
import FirebaseAuth

class PatientViewController: UITableViewController {
    
    let currentUser = Auth.auth().currentUser?.uid
    public var completeDataSource = CompleteList.completeModel

    public var dataSource = PatientList()
    static var isEmpty:Bool = true
    public var noDataLabel = UILabel()
    
    open var data : Any? {
        didSet{
            if data != nil{
            }
            
        }
    }
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        getPatients()
        updateData()
    }
    
    func updateData(){
        tableView.reloadData()
        noDataLabel.isHidden = !dataSource.getPatients().isEmpty
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateData()
    }
    
 
    
    open func prepareView(){
        view.backgroundColor = .white
        self.title = "Patients"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        prepareTableView()
        prepareNoPatientsLabel()
        guard let dataUnwrapped = data as? Patient else{
            return
        }
    }
    
    func prepareTableView() {
        tableView.register(PatientListTVCell.self, forCellReuseIdentifier: PatientListTVCell.description())
        tableView.rowHeight = 120
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = blueColor
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
    open override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            var patientName = dataSource.getDataAtIndex(index: indexPath[1]).name
            let assgignedDrugPatientID =  completeDataSource.getAllData()
            print("Patient name : \(patientName)")
            patientName = patientName + "  "
            for assignments in assgignedDrugPatientID{
                print("assignment \(assignments.patientName)")
                let assignedName = assignments.patientName
                if (patientName == assignedName){
                    print("Assigned name \(assignments.patientName)")
                }
                else{
                    print("Patient name != AssignedName \(patientName)\("")\(assignedName)\("kokot")")
                }
            }
            //NEDOSADÍ SE ID DO NOVÉHO PACIENTA
            //dataSource.deleteData(index: indexPath[1])
            //deleteData(id: patientID ?? "nefunguju :)")
            updateData()
        }
    }
    
    func deleteData(id : String){
        let db = Firestore.firestore()
        db.collection("Patients").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PatientProfileViewController(dataSource: dataSource)
        vc.data = dataSource.getPatients()[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    open override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @objc func addTapped() {
        let vc = AddPatientViewController(dataSource: dataSource)
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.reloadData()
        PatientViewController.isEmpty = false
    
    }
    

    public func getPatients(){
        let db = Firestore.firestore()
        let refPatients = db.collection("Patients")
        
        refPatients.getDocuments{snapshot, error in
                         guard error == nil else {
            print(error!.localizedDescription)
            return
        }
            if let snapshot = snapshot {
                for document in snapshot.documents{
                    let data = document.data()
                    let patientName = data["name"] as? String ?? ""
                    let patientSurname = data["surname"] as? String ?? ""
                    let room = data["room"] as? String ?? ""
                    let bed = data["bed"] as? String ?? ""
                    let gender = data["gender"] as? String ?? ""
                    let patientInfo = data["patient_info"] as? String ?? ""
                    let addedByUser = data["added_by_user"] as? String ?? ""
                    if(addedByUser == self.currentUser!){
                        let PatientNew = Patient(name: patientName, surname: patientSurname, room: room, bed: bed, patientInfo: patientInfo, Gender: gender, addedByUser: self.currentUser!, ID: document.documentID)
                        self.dataSource.addPatient(patient: PatientNew)
                    }
                }

            }
            self.updateData()
        }
    }
    
}





