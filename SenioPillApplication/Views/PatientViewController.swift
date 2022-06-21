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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    open func prepareView(){
        view.backgroundColor = .white
        self.title = "Seznam pacientů"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    func prepareTableView(){
    }
    
    /*open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PatientList.shared, for: indexPath) as? PatientList else {
            return UITableViewCell()
        }
        cell.data = dataSource.getTasks()[indexPath.row]
        return cell
    }
    */
    @objc func addTapped() {
        let vc = AddPatientViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

