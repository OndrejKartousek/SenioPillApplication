//
//  PatientList.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 20.06.2022.
//

import Foundation

public class PatientList{
    static let shared = PatientList(arrayOfPatiens: [])
    private var patientList : [Patient]
    
    
    
    init (arrayOfPatiens : [Patient]){
        self.patientList = arrayOfPatiens
    
    }
    
    public func getPatientList() -> [Patient]{
        return patientList
    }
    
    public func setPatientList(patient : Patient){
        patientList.append(patient)
    }
    
}
