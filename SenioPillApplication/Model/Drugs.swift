//
//  Drugs.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 20.06.2022.
//

import Foundation

public struct Drugs : Codable{
    public var name : String
    public var description : String
    public var PrescriptedDosage : String
    public var addedByUser : String
    public var ID : String
    
    init(name : String, description : String, PrescriptedDosage : String, addedByUser : String, ID : String){
        self.name = name
        self.description = description
        self.PrescriptedDosage = PrescriptedDosage
        self.addedByUser = addedByUser
        self.ID = ID
    }
}
