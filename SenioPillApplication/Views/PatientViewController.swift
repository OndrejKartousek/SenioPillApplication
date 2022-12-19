//
//  ViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 15.06.2022.
//

import SnapKit
import Foundation
import UIKit


class PatientViewController: UITableViewController {
    
    public var dataSource = PatientList()
    static var isEmpty:Bool = true
    public var noDataLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
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
        prepareLicenceAgreementText()
    }
    
    func prepareTableView() {
        tableView.register(PatientListTVCell.self, forCellReuseIdentifier: PatientListTVCell.description())
        tableView.rowHeight = 120
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = blueColor
        print("xy")
    }
    
    func prepareLicenceAgreementText(){
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
    
    
}

