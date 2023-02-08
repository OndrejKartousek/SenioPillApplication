//
//  GivenDrugDetailsVC.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 01.02.2023.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class GivingDrugDetailsVC : UIViewController{
    
    let currentUser = Auth.auth().currentUser?.uid

    public var drugsDataSource : Drugs?
    public var patientDataSource : Patient?
    let giveDrugButton = UIButton()
    let dosageInput = BaseTextField()
    var dataSource: PatientList?
    
    let timePicker = UIDatePicker()
    
    
    var buttonBottomConstraint : Constraint!
    let mondaySwitch = UISwitch()
    let tuesdaySwitch = UISwitch()
    let wednesdaySwitch = UISwitch()
    let thursdaySwitch = UISwitch()
    let fridaySwitch = UISwitch()
    let saturdaySwitch = UISwitch()
    let sundaySwitch = UISwitch()
    
    let mondaySwitchTitle = UILabel()
    let tuesdaySwitchTitle = UILabel()
    let wednesdaySwitchTitle = UILabel()
    let thursdaySwitchTitle = UILabel()
    let fridaySwitchTitle = UILabel()
    let saturdaySwitchTitle = UILabel()
    let sundaySwitchTitle = UILabel()
    
    var mondayState = false
    var tuesdayState = false
    var wednesdayState = false
    var thursdayState = false
    var fridayState = false
    var saturdayState = false
    var sundayState = false
    
    var patientID = ""
    var drugID = ""
    open var data : Any? {
        didSet{
            if data != nil{
                updateView()
            }
            
        }
    }
    
    init(dataSource: Patient?, drugDetails: Drugs?){
        super.init(nibName: nil, bundle: nil)
        print(dataSource)
        print(drugDetails)
        self.drugsDataSource = drugDetails
        self.patientDataSource = dataSource
        patientID = dataSource?.ID ??  ""
        drugID = drugDetails?.ID ?? ""
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        updateView()
        prepareDosageInput()
        prepareTimeInput()
        giveDrugButton.isEnabled = false
        
        prepareMondayInput()
        prepareTuesdayInput()
        prepareWednesdyInput()
        prepareThursdayInput()
        prepareFridayInput()
        prepareSaturdayInput()
        prepareSundayInput()
        
        prepareMondayTitle()
        prepareTuesdayTitle()
        prepareWednesdayTitle()
        prepareThursdayTitle()
        prepareFridayTitle()
        prepareSaturdayTitle()
        prepareSundayTitle()
        
        prepareButton()
    }
    
    open func updateView(){
        guard let dataUnwrapped = data as? Patient else{
            return
        }
        
    }
    
    
    open func prepareView(){
        self.title = "Insert giving information"
        view.backgroundColor = .white
    }
    
    func getInputTitle(text: String?) -> UILabel {
        let inputTitle = UILabel()
        inputTitle.text = text
        inputTitle.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return inputTitle
    }
    
    func prepareInput(_ textField: UITextField, placeholder: String?) {
        textField.placeholder = placeholder
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        textField.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
    }
    
    @objc open func textFieldChanged() {
        giveDrugButton.isEnabled = dosageInput.text?.isEmpty == false && (mondaySwitch.isOn || tuesdaySwitch.isOn || wednesdaySwitch.isOn || thursdaySwitch.isOn || fridaySwitch.isOn || saturdaySwitch.isOn || sundaySwitch.isOn) == true
    }
    
    func prepareDosageInput(){
        let inputTitle = getInputTitle(text : "Dosage")
        view.addSubview(inputTitle)
        inputTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        prepareInput(dosageInput, placeholder: "1ml")
        dosageInput.autocapitalizationType = .none
        dosageInput.autocorrectionType = .no
        view.addSubview(dosageInput)
        dosageInput.snp.remakeConstraints{ make in
            make.top.equalTo(inputTitle.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
    }
    
    func prepareTimeInput(){
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .compact
        view.addSubview(timePicker)
        timePicker.snp.makeConstraints { make in
            make.top.equalTo(dosageInput).offset(70)
            make.leading.equalToSuperview().offset(20)
        }
    }

    func prepareMondayInput(){
        view.addSubview(mondaySwitch)
        mondaySwitch.addTarget(self, action: #selector(textFieldChanged), for: .allTouchEvents)
        mondaySwitch.snp.makeConstraints { make in
            make.top.equalTo(timePicker).offset(50)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    func prepareMondayTitle(){
        view.addSubview(mondaySwitchTitle)
        mondaySwitchTitle.text = "Monday"
        mondaySwitchTitle.snp.makeConstraints { make in
            make.top.equalTo(mondaySwitch).offset(5)
            make.leading.equalToSuperview().offset(80)
        }
    }
    
    func prepareTuesdayInput(){
        view.addSubview(tuesdaySwitch)
        tuesdaySwitch.addTarget(self, action: #selector(textFieldChanged), for: .allTouchEvents)
        tuesdaySwitch.snp.makeConstraints { make in
            make.top.equalTo(timePicker).offset(85)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    func prepareTuesdayTitle(){
        view.addSubview(tuesdaySwitchTitle)
        tuesdaySwitchTitle.text = "Tuesday"
        tuesdaySwitchTitle.snp.makeConstraints { make in
            make.top.equalTo(tuesdaySwitch).offset(5)
            make.leading.equalToSuperview().offset(80)
        }
    }

    func prepareWednesdyInput(){
        view.addSubview(wednesdaySwitch)
        wednesdaySwitch.addTarget(self, action: #selector(textFieldChanged), for: .allTouchEvents)
        wednesdaySwitch.snp.makeConstraints { make in
            make.top.equalTo(timePicker).offset(120)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    func prepareWednesdayTitle(){
        view.addSubview(wednesdaySwitchTitle)
        wednesdaySwitchTitle.text = "Wednesday"
        wednesdaySwitchTitle.snp.makeConstraints { make in
            make.top.equalTo(wednesdaySwitch).offset(5)
            make.leading.equalToSuperview().offset(80)
        }
    }
    
    func prepareThursdayInput(){
        view.addSubview(thursdaySwitch)
        thursdaySwitch.addTarget(self, action: #selector(textFieldChanged), for: .allTouchEvents)
        thursdaySwitch.snp.makeConstraints { make in
            make.top.equalTo(timePicker).offset(155)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    func prepareThursdayTitle(){
        view.addSubview(thursdaySwitchTitle)
        thursdaySwitchTitle.text = "Thursday"
        thursdaySwitchTitle.snp.makeConstraints { make in
            make.top.equalTo(thursdaySwitch).offset(5)
            make.leading.equalToSuperview().offset(80)
        }
    }
    
    func prepareFridayInput(){
        view.addSubview(fridaySwitch)
        fridaySwitch.addTarget(self, action: #selector(textFieldChanged), for: .allTouchEvents)
        fridaySwitch.snp.makeConstraints { make in
            make.top.equalTo(timePicker).offset(190)
            make.leading.equalToSuperview().offset(20)

        }
    }
    
    func prepareFridayTitle(){
        view.addSubview(fridaySwitchTitle)
        fridaySwitchTitle.text = "Friday"
        fridaySwitchTitle.snp.makeConstraints { make in
            make.top.equalTo(fridaySwitch).offset(5)
            make.leading.equalToSuperview().offset(80)
        }
    }
    
    func prepareSaturdayInput(){
        view.addSubview(saturdaySwitch)
        saturdaySwitch.addTarget(self, action: #selector(textFieldChanged), for: .allTouchEvents)
        saturdaySwitch.snp.makeConstraints { make in
            make.top.equalTo(timePicker).offset(225)
            make.leading.equalToSuperview().offset(20)

        }
    }
    
    func prepareSaturdayTitle(){
        view.addSubview(saturdaySwitchTitle)
        saturdaySwitchTitle.text = "Saturday"
        saturdaySwitchTitle.snp.makeConstraints { make in
            make.top.equalTo(saturdaySwitch).offset(5)
            make.leading.equalToSuperview().offset(80)
        }
    }

    func prepareSundayInput(){
        view.addSubview(sundaySwitch)
        sundaySwitch.addTarget(self, action: #selector(textFieldChanged), for: .allTouchEvents)
        sundaySwitch.snp.makeConstraints { make in
            make.top.equalTo(timePicker).offset(260)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    func prepareSundayTitle(){
        view.addSubview(sundaySwitchTitle)
        sundaySwitchTitle.text = "Sunday"
        sundaySwitchTitle.snp.makeConstraints { make in
            make.top.equalTo(sundaySwitch).offset(5)
            make.leading.equalToSuperview().offset(80)
        }
    }
    
    func prepareButton(){
        giveDrugButton.setTitle("Give drug!", for: .normal)
        giveDrugButton.setTitleColor(.white, for: .normal)
        giveDrugButton.setTitleColor(.white.withAlphaComponent(0.2), for: .disabled)
        giveDrugButton.backgroundColor = blueColor
        giveDrugButton.layer.borderWidth = 1
        giveDrugButton.layer.cornerRadius = 30
        giveDrugButton.layer.borderColor = UIColor(red: 237.0 / 255.0, green: 242.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0).cgColor
        giveDrugButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        giveDrugButton.addTarget(self, action: #selector(printAll), for: .primaryActionTriggered)
        view.addSubview(giveDrugButton)
        giveDrugButton.snp.makeConstraints {make in
            make.leading.trailing.equalToSuperview().inset(60)
            self.buttonBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint.update(offset: -30)
            make.bottom.equalToSuperview().offset(50)
            make.height.equalTo(60)
        }
    }
    
    @objc func printAll(){
        print("--------------------printAll-------------------------")
        print(patientID)
        print(drugID)
        print(dosageInput.text!)
        let date = timePicker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = components.hour!
        let minute = components.minute!
        print(hour)
        print(minute)
        mondayState = mondaySwitch.isOn
        tuesdayState = tuesdaySwitch.isOn
        wednesdayState = tuesdaySwitch.isOn
        thursdayState = thursdaySwitch.isOn
        fridayState = fridaySwitch.isOn
        saturdayState = fridaySwitch.isOn
        sundayState = sundaySwitch.isOn
        print(mondayState)
        print(tuesdayState)
        print(wednesdayState)
        print(thursdayState)
        print(fridayState)
        print(saturdayState)
        print(sundayState)
        
        //let completeModel = AssignedModel(creatorID: currentUser!, description: "", patientID: patientID, patientName: patientDataSource!.name, patientSurname: patientDataSource!.surname, patientRoom: patientDataSource!.room, patientBed: patientDataSource!.bed, patientInfo: patientDataSource!.patientInfo, Gender: patientDataSource!.Gender, addedByUser: patientDataSource!.addedByUser, drugID: drugID, drugName: drugsDataSource!.name, drugDescription: drugsDataSource!.description, drugPrescriptedDosage: drugsDataSource!.PrescriptedDosage, givenDrugDosage: dosageInput.text!, givenDrugHour: hour, givenDrugMinute: minute, givenOnMonday: mondayState, givenOnTuesday: tuesdayState, givenOnWednesday: wednesdayState, givenOnThursday: thursdayState, givenOnFriday: fridayState, givenOnSaturday: saturdayState, givenOnSunday: sundayState)
                
        let db = Firestore.firestore()
        
        db.collection("AssignedDrugs").document().setData(["UserID" : currentUser!, "PatientID" : patientID, "DrugID" : drugID, "Patient_Name" : patientDataSource!.name, "Patient_Surname" : patientDataSource?.surname, "Patient_Bed" : patientDataSource?.bed, "Patient_Room" : patientDataSource?.room, "Patient_Info" : patientDataSource?.patientInfo, "Patient_Gender" : patientDataSource?.Gender, "Added_By_User" : patientDataSource?.addedByUser, "Drug_Name" : drugsDataSource?.name, "Drug_Description" : drugsDataSource?.description, "Drug_Prescripted_Dosage" : drugsDataSource?.PrescriptedDosage,"Given_Dosage" : dosageInput.text!, "Given_Hour" : hour, "Given_Minute" : minute, "Monday" : mondayState, "Tuesday" : tuesdayState, "Wednesday" : wednesdayState, "Thursday" : thursdayState, "Friday" : fridayState, "Saturday" : saturdayState, "Sunday" : sundayState ]) { (err) in
            
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
        }
    }
}
