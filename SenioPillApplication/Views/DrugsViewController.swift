//
//  DrugsControllerViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 15.06.2022.
//

import UIKit

class DrugsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    open func prepareView(){
        self.title = "Seznam léků"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        let vc = AddDrugViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

}
