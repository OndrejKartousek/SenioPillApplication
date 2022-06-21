//
//  Drugs.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 20.06.2022.
//

import Foundation

public struct Drugs : Codable{
    public var id : Int
    public var name : String
    public var description : String
    public var PrescriptedDosage : String
    
    init(id : Int, name : String, description : String, PrescriptedDosage : String){
        self.id = 1
        self.name = name
        self.description = description
        self.PrescriptedDosage = PrescriptedDosage
    }
}
