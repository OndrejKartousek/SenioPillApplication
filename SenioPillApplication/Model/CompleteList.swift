//
//  CompleteList.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 08.02.2023.
//

import Foundation

public class CompleteList : CompletePatientRepository{
    
    private var assignedModelData : [AssignedModel] = []
    
    public init(){
        
    }
    init(arrayOfCompleteObjc : [AssignedModel]){
        self.assignedModelData = arrayOfCompleteObjc
    }

    func getAllData() -> [AssignedModel] {
        return assignedModelData
    }
    func addData(data: AssignedModel) -> AssignedModel? {
        self.assignedModelData.append(data)
        return data
    }
    func getConcreteData(id: String) -> AssignedModel? {
        for assignedModelDataX in assignedModelData {
            if(assignedModelDataX.ID == id){
                return assignedModelDataX
            }
        }
        return assignedModelData.first
    }
}
