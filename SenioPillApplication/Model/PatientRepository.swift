//
//  PatientRepository.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 21.06.2022.
//

import Foundation

protocol PatientRepository {
    func getPatients() -> [Patient]
    func getPatient(id : String) -> Patient?
    func addPatient(patient : Patient) -> Patient?
}
