//
//  DrugsControllerViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 15.06.2022.
//

import UIKit
import SnapKit
import Foundation

class DrugsViewController: UITableViewController {

    public var noDataLabel = UILabel()
    public var dataSource = DrugsList()
    
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
    
    open override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataSource.deleteDrug(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            noDataLabel.isHidden = !dataSource.getDrugs().isEmpty
        }
    }
    
    @objc func addTapped() {
        let vc = AddDrugViewController(dataSource: dataSource)
        self.navigationController?.pushViewController(vc, animated: true)
        prepareTableView()
    }
    

    

}
