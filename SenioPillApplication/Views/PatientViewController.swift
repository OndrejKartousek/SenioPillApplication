//
//  ViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 15.06.2022.
//

import UIKit
import SnapKit

class PatientViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    open func prepareView(){
        view.backgroundColor = .white
        prepareLabel()
    }
    
    func prepareLabel(){
        let label = UILabel()
        label.text = "Pacienti"
        view.addSubview(label)
        label.snp.makeConstraints{make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
    }
}

