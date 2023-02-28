//
//  PatientList.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 20.06.2022.
//

import Foundation

public class PatientList : PatientRepository{
    
    private var patients : [Patient] = []
    
    public init(){
    }
    
    func deletePatient(at index: Int) {
         patients.remove(at: index)
     }
    
    func getPatients() -> [Patient] {
        return patients
    }
    
    func getDataAtIndex(index: Int)-> Patient{
        return patients[index]
    }
    
    func getPatient(id: String) -> Patient? {
        for patient in patients {
            if(patient.ID == id){
                return patient
            }
        }
        return patients.first
    }
    
    func addPatient(patient: Patient) -> Patient? {
        self.patients.append(patient)
        return patient
    }
    
    func editPatient(patient: Patient) -> Patient?{
        for (index, patientos) in patients.enumerated(){
            print(patient.ID)
            if patient.ID! == patientos.ID{
                print(patient.ID)
                patients[index] = patient
                
            }
        }
        return patient
    }

    init (arrayOfPatiens : [Patient]){
        self.patients = arrayOfPatiens
    
    }
    
    public func getPatientList() -> [Patient]{
        return patients
    }
    
    public func setPatientList(patient : Patient){
        patients.append(patient)
    }
    
    public func deleteData(index: Int){
        patients.remove(at: index)
    }
    
    
    
}
