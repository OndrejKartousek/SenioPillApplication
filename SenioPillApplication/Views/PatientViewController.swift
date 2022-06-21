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
    var users : [Patient] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    open func prepareView(){
        view.backgroundColor = .white
        self.title = "Seznam pacientů"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    func prepareTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        tableView.register(PatientListTVCell.self, forCellReuseIdentifier: PatientListTVCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
    }

    // MARK: - UITableViewDelegate
    // MARK: - Function counts how many cells will be displayed
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    // MARK: - Function creates instance of UITableViewCell for every displayed row
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: PatientListTVCell.reuseIdentifier) as? PatientListTVCell ?? PatientListTVCell()
        if users.count > indexPath.row {
            cell.data = users[indexPath.row]
        }
        return cell
    }

    
    
    
    @objc func addTapped() {
        let vc = AddPatientViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

