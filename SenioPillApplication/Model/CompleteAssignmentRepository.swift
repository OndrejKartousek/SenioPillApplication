//
//  CompleteAssignmentRepository.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 08.02.2023.
//

import Foundation

protocol CompletePatientRepository{
    func getAllData() -> [AssignedModel]
    func getConcreteData(id: String) -> AssignedModel?
}
