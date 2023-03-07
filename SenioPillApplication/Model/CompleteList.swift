//
//  CompleteList.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 08.02.2023.
//

import Foundation
import FirebaseFirestore

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
    
    func getDataAtIndex(index: Int)-> AssignedModel{
        print("getCompleteModel")
        print(CompleteList.completeModel.assignedModelData)
        return CompleteList.completeModel.assignedModelData[index]
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
    
    public func setEmptyDataList(){
        assignedModelData = []
    }
    
    public func deleteData(index: Int){
        assignedModelData.remove(at: index)
    }
    
    public func deleteById(id:String){
        assignedModelData.removeAll(where: {$0.ID == id})
    }
    
    
    public func removeWithPatientId(id:String){
        assignedModelData.removeAll{$0.patientID == id}
    }
    
    public func updateDashboard(pacient : Patient){
        for (index, assignment) in assignedModelData.enumerated(){
            if assignment.patientID == pacient.ID{
                
                let updatedModel = AssignedModel(ID: assignment.ID, creatorID: assignment.creatorID, description: assignment.description, patientID: pacient.ID!, patientName: pacient.name, patientSurname: pacient.surname, patientRoom: pacient.room, patientBed: pacient.bed, patientInfo: pacient.patientInfo, Gender: pacient.Gender, addedByUser: assignment.addedByUser, drugID: assignment.drugID, drugName: assignment.drugName, drugDescription: assignment.drugDescription, drugPrescriptedDosage: assignment.drugPrescriptedDosage, givenDrugDosage: assignment.givenDrugDosage, givenDrugHour: assignment.givenDrugHour, givenDrugMinute: assignment.givenDrugMinute, givenOnMonday: assignment.givenOnMonday, givenOnTuesday: assignment.givenOnTuesday, givenOnWednesday: assignment.givenOnWednesday, givenOnThursday: assignment.givenOnThursday, givenOnFriday: assignment.givenOnFriday, givenOnSaturday: assignment.givenOnSaturday, givenOnSunday: assignment.givenOnSunday, NextDateToGive: assignment.nextDateToGive)
                
                assignedModelData[index] = updatedModel
                
                let db = Firestore.firestore()
                db.collection("AssignedDrugs").document(updatedModel.ID).updateData(["Patient_Name": updatedModel.patientName, "Patient_Surname" : updatedModel.patientSurname, "Patient_Room" : updatedModel.patientRoom, "Patient_Bed" : updatedModel.patientBed, "gender" : updatedModel.Gender, "Patient_Info" : updatedModel.patientInfo])
            }
        }
    }
    
    func editModel(model: AssignedModel) -> AssignedModel?{
        
        for (index, modelos) in assignedModelData.enumerated(){
            print(model.ID)
            if model.ID == modelos.ID{
                print(model.ID)
                assignedModelData[index] = model
                
            }
        }
        return model
    }
}
