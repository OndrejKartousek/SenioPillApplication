//
//  DrugsControllerViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 15.06.2022.
//

import UIKit
import SnapKit
import Foundation
import FirebaseFirestore
import FirebaseAuth

class DrugsViewController: UITableViewController {
    
    let currentUser = Auth.auth().currentUser?.uid
    
    public var noDataLabel = UILabel()
    public var dataSource = DrugsList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        getDrugs()
        updateData()
    }
    
    func updateData(){
        tableView.reloadData()
        noDataLabel.isHidden = !dataSource.getDrugs().isEmpty
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateData()
    }
    
    open func prepareView(){
        view.backgroundColor = .white
        self.title = "Drugs"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        prepareTableView()
        prepareNodataText()
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
        return dataSource.getDrugs().count

    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DrugListTVCell.description(), for: indexPath) as? DrugListTVCell else {
            return UITableViewCell()
        }
        cell.data = dataSource.getDrugs()[indexPath.row]
        return cell
    }
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DrugsInfoViewController(dataSource: dataSource)
        vc.data = dataSource.getDrugs()[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    open override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 
    @objc func addTapped() {
        let vc = AddDrugViewController(dataSource: dataSource)
        self.navigationController?.pushViewController(vc, animated: true)
        prepareTableView()
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
                    let randomInt = data["randomInt"] as? Int ?? 1

                    if(addedByUser == self.currentUser!){
                        let DrugNew = Drugs(name: drugName, description: drugDescription, PrescriptedDosage: drugDosage, addedByUser: self.currentUser!, ID: document.documentID, randomInt: randomInt)
                        self.dataSource.addDrug(drug: DrugNew)
                    }
                }
            }
            self.updateData()
        }
    }

    

}
