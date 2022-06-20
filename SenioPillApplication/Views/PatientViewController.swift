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
    
    @objc func addTapped() {
        let vc = AddPatientViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

