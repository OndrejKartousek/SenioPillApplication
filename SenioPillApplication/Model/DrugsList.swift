//
//  DrugsList.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 21.06.2022.
//

import Foundation

public class DrugsList : DrugsRepository{
    
    private var drugs: [Drugs] = []

    public init(){
        
    }
    
    func deleteDrug(at index : Int){
        drugs.remove(at: index)
    }
    
    func getDrugs(id: Int) -> Drugs? {
        return drugs.first
    }
        
    func getDrugs() -> [Drugs] {
        return drugs
    }
    
    func addDrug(drug: Drugs) -> Drugs? {
        self.drugs.append(drug)
        return drug
    }

    init (arrayOfDrugs : [Drugs]){
        self.drugs = arrayOfDrugs
    
    }
    
    public func getDrugsList() -> [Drugs]{
        return drugs
    }
    
    public func setDrugsList(drug : Drugs){
        drugs.append(drug)
    }
    
}
