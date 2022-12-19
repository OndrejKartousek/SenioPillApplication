//
//  DashboardViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 17.06.2022.
//

import Foundation
import UIKit

class DashboardViewController : UIViewController{
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        prepareView()
    }
    
    open func prepareView(){
        view.backgroundColor = .white
        self.title = "Dashboard"
    }
    
    private func setupUI(){
        self.view.backgroundColor = .systemBackground
    }
  

    
}
