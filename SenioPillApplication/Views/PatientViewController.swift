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
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        print(PatientViewController.isEmpty)
    }
    
    open func prepareView(){
        view.backgroundColor = .white
        self.title = "Seznam pacientů"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        prepareTableView()
        if(PatientViewController.isEmpty != true){
            
        }else{
        prepareLicenceAgreementText()
        }
    }
    
    func prepareTableView() {
        tableView.register(PatientListTVCell.self, forCellReuseIdentifier: PatientListTVCell.description())
        tableView.rowHeight = 80
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .green
    }
    
    func prepareLicenceAgreementText(){
        let label = UILabel()
        if(PatientViewController.isEmpty != true){
            label.text = ""
            label.isHidden = true
        }
        else{
            label.text = "Zatím nebyl přidán žádný pacient"
            label.isHidden = false

        }
        
        view.addSubview(label)
        label.snp.makeConstraints{make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(350)
            make.leading.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
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
    
    @objc func addTapped() {
        let vc = AddPatientViewController(dataSource: dataSource)
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.reloadData()
        PatientViewController.isEmpty = false
        viewDidLoad()
        print(PatientViewController.isEmpty)
    }
    
    
}

