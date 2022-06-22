//
//  DrugsRepository.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 22.06.2022.
//

import Foundation

protocol DrugsRepository {
    func getDrugs() -> [Drugs]
    func getDrugs(id : Int) -> Drugs?
    func addDrug(drug : Drugs) -> Drugs?
}
