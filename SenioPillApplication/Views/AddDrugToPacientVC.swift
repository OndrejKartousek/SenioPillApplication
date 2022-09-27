//
//  AddDrugToPacientVC.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 24.06.2022.
//

import Foundation
import UIKit
import SnapKit

class AddDrugToPacientVC: UITableViewController{
    
    public var dataSource = DrugsList()
    public var noDataLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateData()
        print(dataSource.getDrugs())
    }
    
    func updateData(){
        tableView.reloadData()
        noDataLabel.isHidden = !dataSource.getDrugs().isEmpty
    }
    
    open func prepareView(){
        view.backgroundColor = .white
        self.title = "Přiřadit lék"
        prepareTableView()
        prepareLicenceAgreementText()
    }
    
    func prepareLicenceAgreementText(){
        noDataLabel.isHidden = true
        noDataLabel.text = "Zatím nebyl přidán žádný lék"
        tableView.addSubview(noDataLabel)
        noDataLabel.snp.makeConstraints{make in
            make.center.equalToSuperview()
        }
    }
    
    func prepareTableView() {
        tableView.register(AddDrugToPatientTVCell.self, forCellReuseIdentifier: AddDrugToPatientTVCell.description())
        tableView.rowHeight = 90
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .green
        print("xy")
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
        return dataSource.getDrugs().count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddDrugToPatientTVCell.description(), for: indexPath) as? AddDrugToPatientTVCell else {
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
}
