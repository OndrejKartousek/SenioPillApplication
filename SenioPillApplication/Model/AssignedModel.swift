//
//  AssignedModel.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 08.02.2023.
//

import Foundation

public struct AssignedModel : CustomStringConvertible{
    public var description: String
    
    public var creatorID : String
    public var ID : String
    public var patientID : String
    public var patientName : String
    public var patientSurname : String
    public var patientRoom : String
    public var patientBed : String
    public var patientInfo : String
    public var Gender : String
    public var addedByUser : String
    
    public var drugID : String
    public var drugName : String
    public var drugDescription : String
    public var drugPrescriptedDosage : String
    
    public var givenDrugDosage : String
    public var givenDrugHour : Int
    public var givenDrugMinute : Int
    public var givenOnMonday : Bool
    public var givenOnTuesday : Bool
    public var givenOnWednesday : Bool
    public var givenOnThursday : Bool
    public var givenOnFriday : Bool
    public var givenOnSaturday : Bool
    public var givenOnSunday : Bool
    
    init(ID : String, creatorID : String, description : String, patientID : String, patientName : String, patientSurname : String, patientRoom : String, patientBed : String, patientInfo : String, Gender : String, addedByUser : String, drugID : String, drugName : String, drugDescription : String, drugPrescriptedDosage : String, givenDrugDosage: String, givenDrugHour: Int, givenDrugMinute: Int, givenOnMonday: Bool, givenOnTuesday: Bool, givenOnWednesday: Bool, givenOnThursday: Bool, givenOnFriday: Bool, givenOnSaturday: Bool, givenOnSunday: Bool) {
         
        self.description = description
        self.creatorID = creatorID
        self.ID = ID
        self.patientID = patientID
        self.patientName = patientName
        self.patientSurname = patientSurname
        self.patientRoom = patientRoom
        self.patientBed = patientBed
        self.patientInfo = patientInfo
        self.Gender = Gender
        self.addedByUser = addedByUser
        
        self.drugID = drugID
        self.drugName = drugName
        self.drugDescription = description
        self.drugPrescriptedDosage = drugPrescriptedDosage
        
        self.givenDrugDosage = givenDrugDosage
        self.givenDrugHour = givenDrugHour
        self.givenDrugMinute = givenDrugMinute
        
        self.givenOnMonday = givenOnMonday
        self.givenOnTuesday = givenOnTuesday
        self.givenOnWednesday = givenOnWednesday
        self.givenOnThursday = givenOnThursday
        self.givenOnFriday = givenOnFriday
        self.givenOnSaturday = givenOnSaturday
        self.givenOnSunday = givenOnSunday
    }
}
