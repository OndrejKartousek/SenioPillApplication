//
//  AssignedModel.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 08.02.2023.
//

import Foundation

public struct AssignedModel : CustomStringConvertible{
    

    var calendar = Calendar.current
    
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
    public var nextDateToGive: Date
    
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
    
    init(ID : String, creatorID : String, description : String, patientID : String, patientName : String, patientSurname : String, patientRoom : String, patientBed : String, patientInfo : String, Gender : String, addedByUser : String, drugID : String, drugName : String, drugDescription : String, drugPrescriptedDosage : String, givenDrugDosage: String, givenDrugHour: Int, givenDrugMinute: Int, givenOnMonday: Bool, givenOnTuesday: Bool, givenOnWednesday: Bool, givenOnThursday: Bool, givenOnFriday: Bool, givenOnSaturday: Bool, givenOnSunday: Bool, NextDateToGive: Date?) {
         
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
        
        if let date = NextDateToGive {
            self.nextDateToGive = date
        }else {
            nextDateToGive = Date()
            getNextDateToGive(includeToday: true)
        }
    }
    
    public mutating func getNextDateToGive(includeToday: Bool){
        let dayInWeek = Calendar.current.dateComponents([.weekday], from: Date()).weekday
        switch dayInWeek {
        case 1:
                if(includeToday && givenOnSunday){
                    self.nextDateToGive = Date()
                } else if(givenOnMonday){
                    self.nextDateToGive = getDateByDistance(howManyDays: 1)
                } else if(givenOnTuesday){
                    self.nextDateToGive = getDateByDistance(howManyDays: 2)
                } else if(givenOnWednesday){
                    self.nextDateToGive = getDateByDistance(howManyDays: 3)
                } else if(givenOnThursday){
                    self.nextDateToGive = getDateByDistance(howManyDays: 4)
                } else if(givenOnFriday){
                    self.nextDateToGive = getDateByDistance(howManyDays: 5)
                } else if(givenOnSaturday){
                    self.nextDateToGive = getDateByDistance(howManyDays: 6)
                }
        case 2:
            if(includeToday && givenOnMonday){
                self.nextDateToGive = Date()
            } else if(givenOnTuesday){
                self.nextDateToGive = getDateByDistance(howManyDays: 1)
            } else if(givenOnWednesday){
                self.nextDateToGive = getDateByDistance(howManyDays: 2)
            } else if(givenOnThursday){
                self.nextDateToGive = getDateByDistance(howManyDays: 3)
            } else if(givenOnFriday){
                self.nextDateToGive = getDateByDistance(howManyDays: 4)
            } else if(givenOnSaturday){
                self.nextDateToGive = getDateByDistance(howManyDays: 5)
            } else if(givenOnSunday){
                self.nextDateToGive = getDateByDistance(howManyDays: 6)
            }
        case 3:
            if(includeToday && givenOnTuesday){
                self.nextDateToGive = Date()
            } else if(givenOnWednesday){
                self.nextDateToGive = getDateByDistance(howManyDays: 1)
            } else if(givenOnThursday){
                self.nextDateToGive = getDateByDistance(howManyDays: 2)
            } else if(givenOnFriday){
                self.nextDateToGive = getDateByDistance(howManyDays: 3)
            } else if(givenOnSaturday){
                self.nextDateToGive = getDateByDistance(howManyDays: 4)
            } else if(givenOnSunday){
                self.nextDateToGive = getDateByDistance(howManyDays: 5)
            } else if(givenOnMonday){
                self.nextDateToGive = getDateByDistance(howManyDays: 6)
            }
        case 4:
            if(includeToday && givenOnWednesday){
                self.nextDateToGive = Date()
            } else if(givenOnThursday){
                self.nextDateToGive = getDateByDistance(howManyDays: 1)
            } else if(givenOnFriday){
                self.nextDateToGive = getDateByDistance(howManyDays: 2)
            } else if(givenOnSaturday){
                self.nextDateToGive = getDateByDistance(howManyDays: 3)
            } else if(givenOnSunday){
                self.nextDateToGive = getDateByDistance(howManyDays: 4)
            } else if(givenOnMonday){
                self.nextDateToGive = getDateByDistance(howManyDays: 5)
            } else if(givenOnTuesday){
                self.nextDateToGive = getDateByDistance(howManyDays: 6)
            }
        case 5:
            if(includeToday && givenOnThursday){
                self.nextDateToGive = Date()
            } else if(givenOnFriday){
                self.nextDateToGive = getDateByDistance(howManyDays: 1)
            } else if(givenOnSaturday){
                self.nextDateToGive = getDateByDistance(howManyDays: 2)
            } else if(givenOnSunday){
                self.nextDateToGive = getDateByDistance(howManyDays: 3)
            } else if(givenOnMonday){
                self.nextDateToGive = getDateByDistance(howManyDays: 4)
            } else if(givenOnTuesday){
                self.nextDateToGive = getDateByDistance(howManyDays: 5)
            } else if(givenOnWednesday){
                self.nextDateToGive = getDateByDistance(howManyDays: 6)
            }
        case 6:
            if(includeToday && givenOnFriday){
                self.nextDateToGive = Date()
            } else if(givenOnSaturday){
                self.nextDateToGive = getDateByDistance(howManyDays: 1)
            } else if(givenOnSunday){
                self.nextDateToGive = getDateByDistance(howManyDays: 2)
            } else if(givenOnMonday){
                self.nextDateToGive = getDateByDistance(howManyDays: 3)
            } else if(givenOnTuesday){
                self.nextDateToGive = getDateByDistance(howManyDays: 4)
            } else if(givenOnWednesday){
                self.nextDateToGive = getDateByDistance(howManyDays: 5)
            } else if(givenOnThursday){
                self.nextDateToGive = getDateByDistance(howManyDays: 6)
            }
        case 7:
            if(includeToday && givenOnSaturday){
                self.nextDateToGive = Date()
            } else if(givenOnSunday){
                self.nextDateToGive = getDateByDistance(howManyDays: 1)
            } else if(givenOnMonday){
                self.nextDateToGive = getDateByDistance(howManyDays: 2)
            } else if(givenOnTuesday){
                self.nextDateToGive = getDateByDistance(howManyDays: 3)
            } else if(givenOnWednesday){
                self.nextDateToGive = getDateByDistance(howManyDays: 4)
            } else if(givenOnThursday){
                self.nextDateToGive = getDateByDistance(howManyDays: 5)
            } else if(givenOnFriday){
                self.nextDateToGive = getDateByDistance(howManyDays: 6)
            }
        case .none:
            return
        case .some(_):
            return
        }
        
        print("Další den \(nextDateToGive)")
    }
    
    public func getDateByDistance(howManyDays:Int)->Date{
        return calendar.date(byAdding: .day, value: howManyDays, to: Date())!
    }
}
