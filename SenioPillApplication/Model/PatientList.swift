//
//  PatientList.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 20.06.2022.
//

import Foundation

public class PatientList : PatientRepository{
    
    private var patients : [Patient] = []
    private let patientCount = 3
    
    public init(){
        for index in 0...patientCount {
            patients.append(Patient(id: index, name: "Jméno", surname: "Příjmení", room: "Pokoj 206", bed: "Lůžko 3", patientInfo: "yy"))
        }
    }
    
    
    func getPatients() -> [Patient] {
        return patients
    }
    
    func getPatient(id: Int) -> Patient? {
        return patients.first
    }
    
    func addPatient(patient: Patient) -> Patient? {
        self.patients.append(patient)
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
    
}
