//
//  CompleteList.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 08.02.2023.
//

import Foundation

public class CompleteList : CompletePatientRepository{
    
    static let completeModel = CompleteList()
    private var assignedModelData : [AssignedModel] = []
    
    private init(){
        
    }
    
    func initiliazer(arrayOfCompleteObjc : [AssignedModel]){
        self.assignedModelData = arrayOfCompleteObjc
    }

    func getAllData() -> [AssignedModel] {
        return assignedModelData
    }
    func addData(data: AssignedModel) -> AssignedModel? {
        self.assignedModelData.append(data)
        return data
    }
    
    init (dataArray : [AssignedModel]){
        self.assignedModelData = dataArray
    }
    func getConcreteData(id: String) -> AssignedModel? {
        for assignedModelDataX in assignedModelData {
            if(assignedModelDataX.ID == id){
                return assignedModelDataX
            }
        }
        return assignedModelData.first
    }
    
    func getUserAssignments(patientId: String) -> [AssignedModel] {
        var data: [AssignedModel] = []
        for assignedModelDataX in assignedModelData {
            if(assignedModelDataX.patientID == patientId){
                data.append(assignedModelDataX)
            }
        }
        return data
    }
    
    public func setDataList(data : AssignedModel){
        assignedModelData.append(data)
    }
}
