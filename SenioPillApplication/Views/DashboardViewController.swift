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
        prepareView()
    }
    
    open func prepareView(){
        view.backgroundColor = .white
        self.title = "Nástěnka"
    }
    
}
