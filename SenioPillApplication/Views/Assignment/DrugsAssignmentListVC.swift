//
//  DrugsAssignmentListVC.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 07.02.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SnapKit
import UIKit

class DrugsAssignmentListVC : UITableViewController{
    let currentUser = Auth.auth().currentUser?.uid
    
    public var noDataLabel = UILabel()
    public var DrugsDS = DrugsList()
    public var PatientDS: Patient? = nil
    
    var userID = ""
    
    open var data : Any? {
        didSet{
            if data != nil{
            }
            
        }
    }
    init(dataSource :Patient?){
        super.init(nibName: nil, bundle: nil)
        self.PatientDS = dataSource
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        getDrugs()
        updateData()
    }
    
    func updateData(){
        print("Karotusek žebrák")
        tableView.reloadData()
        noDataLabel.isHidden = !DrugsDS.getDrugs().isEmpty
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateData()
    }
    
    open func prepareView(){
        view.backgroundColor = .white
        self.title = "Drugs"
        //navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        prepareTableView()
        prepareNodataText()
        guard let dataUnwrapped = data as? Patient else{
            return
        }
    }
    
    func prepareTableView() {
        tableView.register(DrugListTVCell.self, forCellReuseIdentifier: DrugListTVCell.description())
        tableView.rowHeight = 90
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = blueColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func prepareNodataText(){
        noDataLabel.isHidden = true
        noDataLabel.text = "No drugs added yet."
        tableView.addSubview(noDataLabel)
        noDataLabel.snp.makeConstraints{make in
            make.center.equalToSuperview()
        }
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
        print(DrugsDS.getDrugs().count)
        //print("Table view 70")
        return DrugsDS.getDrugs().count

    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("Table view 76")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DrugListTVCell.description(), for: indexPath) as? DrugListTVCell else {
            return UITableViewCell()
        }
        cell.data = DrugsDS.getDrugs()[indexPath.row]
        return cell
    }
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print(DrugsDS.getDrugs()[indexPath.row])
        let vc = GivingDrugDetailsVC(dataSource: PatientDS, drugDetails: DrugsDS.getDrugs()[indexPath.row])
        present(vc, animated : true)
    }
    
    open override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //print("Table view 92")
        return true
    }
    
    public func getDrugs(){
        let db = Firestore.firestore();
        let ref = db.collection("Drugs");
        ref.getDocuments{snapshot, error in
                         guard error == nil else {
            print(error!.localizedDescription)
            return
        }
            if let snapshot = snapshot {
                for document in snapshot.documents{
                    let data = document.data()
                    
                    let drugName = data["name"] as? String ?? ""
                    let addedByUser = data["added_by_user"] as? String ?? ""
                    let drugDescription = data["description"] as? String ?? ""
                    let drugDosage = data["prescriptedDosage"] as? String ?? ""
                    if(addedByUser == self.currentUser!){
                        let DrugNew = Drugs(name: drugName, description: drugDescription, PrescriptedDosage: drugDosage, addedByUser: self.currentUser!, ID: document.documentID)
                        self.DrugsDS.addDrug(drug: DrugNew)
                    }
                }
            }
        }
    }
}
