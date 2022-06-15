//
//  ViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 15.06.2022.
//

import UIKit
import SnapKit

class DrugsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additiona l setup after loading the view.
    }
    
    @IBAction func addPatient(){
        let vc = UIViewController()
        vc.view.backgroundColor = .lightGray
        
        navigationController?.pushViewController(vc, animated: true)
    }

    
    


}

