//
//  Patient.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 20.06.2022.
//

import Foundation

public struct Patient : Codable {
    public var name : String
    public var surname : String
    public var room : String
    public var bed : String
    public var patientInfo : String
    public var Gender : String
    public var addedByUser : String
    public var ID : String?
    
    init(name : String, surname : String, room : String, bed : String, patientInfo : String, Gender : String, addedByUser : String, ID : String?){
        self.name = name
        self.surname = surname
        self.room = room
        self.bed = bed
        self.patientInfo = patientInfo
        self.Gender = Gender
        self.addedByUser = addedByUser
        self.ID = ID
    }

}

