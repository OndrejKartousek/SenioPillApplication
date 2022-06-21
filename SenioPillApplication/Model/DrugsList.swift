//
//  DrugsList.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 21.06.2022.
//

import Foundation

public class DrugsList{
    static let sharedDrugs = DrugsList(arrayOfDrugs: [])
    private var drugsList : [Drugs]
    
    
    
    init (arrayOfDrugs : [Drugs]){
        self.drugsList = arrayOfDrugs
    
    }
    
    public func getDrugsList() -> [Drugs]{
        return drugsList
    }
    
    public func setDrugsList(drugs : Drugs){
        drugsList.append(drugs)
    }
    
}
