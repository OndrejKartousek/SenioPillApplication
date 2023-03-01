//
//  EditPatientVC.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 27.02.2023.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import SnapKit

class EditPatientVC : UIViewController{
    
    let currentUser = Auth.auth().currentUser?.uid

    let addPatientButton = UIButton()
    let nameInput = BaseTextField()
    let surnameInput = BaseTextField()
    let roomInput = BaseTextField()
    let bedInput = BaseTextField()
    let patientInfo = BaseTextField()
    var segmentedControll = UISegmentedControl()
    let items = ["Man 👨🏼‍🦳","Woman 👵🏼","Other 🚁"]
    var buttonBottomConstraint : Constraint!
    var dataSource: PatientList?
    var completeDS : CompleteList = CompleteList.completeModel
    let blueColor = UIColor(red: 24, green: 146, blue: 250)
    public var PatientDS: PatientList? = nil
    var userID = "empty"
    var name = ""
    var surname = ""
    var room = ""
    var bed = ""
    var info = ""
    var gender = ""
    
    
    var completeID = ""
    var creatorID = ""
    var desc = ""
    var patientName = ""
    var patientSurname = ""
    var patientRoom = ""
    var patientBed = ""
    var patientsInfo = ""
    var patientGender = ""
    var drugID = ""
    var drugName = ""
    var drugDesc = ""
    var drugPrescriptedDosage = ""
    var givenDosage = ""
    var drugHour = 0
    var drugMinute = 0
    var giveMon = false
    var givenTue = false
    var givenWed = false
    var givenThur = false
    var givenFri = false
    var givenSat = false
    var givenSun = false

    init(dataSource: PatientList?){
        super.init(nibName: nil, bundle: nil)
        self.dataSource = dataSource
    }
    
    open var data : Any? {
        didSet{
            if data != nil{
                updateView()
            }
        }
    }
    
    open var completeData : Any? {
        didSet{
            if data != nil{
                updateView()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func updateView(){
        guard let dataUnwrapped = data as? Patient else{
            return
        }
        self.userID = dataUnwrapped.ID ?? ""
        self.name = dataUnwrapped.name
        self.surname = dataUnwrapped.surname
        self.room = dataUnwrapped.room
        self.bed = dataUnwrapped.bed
        self.info = dataUnwrapped.patientInfo
        self.gender = dataUnwrapped.Gender
        
        print("dataunwrappedcomplete xy")
        guard let dataUnwrappedComplete = completeData as? AssignedModel else{
            return
        }
        print("\(dataUnwrappedComplete.patientID) dataunwrappedcomplete")
        
        self.completeID = dataUnwrappedComplete.ID
        self.creatorID = dataUnwrappedComplete.creatorID
        self.desc = dataUnwrappedComplete.description
        self.patientName = dataUnwrappedComplete.patientName
        self.patientSurname = dataUnwrappedComplete.patientSurname
        self.patientRoom = dataUnwrappedComplete.patientRoom
        self.patientBed = dataUnwrappedComplete.patientBed
        self.patientsInfo = dataUnwrappedComplete.patientInfo
        self.patientGender = dataUnwrappedComplete.Gender
        self.drugID = dataUnwrappedComplete.drugID
        self.drugName = dataUnwrappedComplete.drugName
        self.drugDesc = dataUnwrappedComplete.drugDescription
        self.drugPrescriptedDosage = dataUnwrappedComplete.drugPrescriptedDosage
        self.givenDosage = dataUnwrappedComplete.givenDrugDosage
        self.drugHour = dataUnwrappedComplete.givenDrugHour
        self.drugMinute = dataUnwrappedComplete.givenDrugMinute
        self.giveMon = dataUnwrappedComplete.givenOnMonday
        self.givenTue = dataUnwrappedComplete.givenOnTuesday
        self.givenWed = dataUnwrappedComplete.givenOnWednesday
        self.givenThur = dataUnwrappedComplete.givenOnThursday
        self.givenFri = dataUnwrappedComplete.givenOnFriday
        self.givenSat = dataUnwrappedComplete.givenOnSaturday
        self.givenSun = dataUnwrappedComplete.givenOnSunday
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareNameInput()
        prepareSurnameInput()
        prepareRoomInput()
        prepareBedInput()
        prepareInfoInput()
        prepareSegmentedControll()
        prepareAddPatientBUtton()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    open func prepareView(){
        self.title = "Add patient"
        view.backgroundColor = .white
    }
    
    func getInputTitle(text: String?) -> UILabel {
        let inputTitle = UILabel()
        inputTitle.text = text
        inputTitle.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return inputTitle
    }
    
    func prepareNameInput(){
        let inputTitle = getInputTitle(text : "Name")
        view.addSubview(inputTitle)
        inputTitle.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(24)
        }
        prepareInput(nameInput, placeholder: "Patient's name")
        nameInput.text = "\(self.name)"
        nameInput.autocapitalizationType = .none
        nameInput.autocorrectionType = .no
        view.addSubview(nameInput)
        nameInput.snp.remakeConstraints{ make in
            make.top.equalTo(inputTitle.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
    }
    
    
    func prepareSurnameInput(){
        let inputTitle = getInputTitle(text : "Surname")
        view.addSubview(inputTitle)
        inputTitle.snp.makeConstraints{ make in
            make.top.equalTo(nameInput.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(24)
        }
        prepareInput(surnameInput, placeholder: "Patient's surname")
        surnameInput.text = "\(self.surname)"
        surnameInput.autocapitalizationType = .none
        surnameInput.autocorrectionType = .no
        view.addSubview(surnameInput)
        surnameInput.snp.remakeConstraints{ make in
            make.top.equalTo(inputTitle.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
    }
    
    func prepareSegmentedControll(){
        let deviceWidth = UIScreen.main.bounds.size.width
        let segmentWidth = (deviceWidth - 50) / 3
        segmentedControll = UISegmentedControl(items: items)
        let genderTitle = getInputTitle(text: "Gender")
        
        view.addSubview(genderTitle)
        segmentedControll.backgroundColor = .clear
        segmentedControll.selectedSegmentTintColor = blueColor
        segmentedControll.setWidth(segmentWidth, forSegmentAt: 0)
        segmentedControll.setWidth(segmentWidth, forSegmentAt: 1)
        segmentedControll.setWidth(segmentWidth, forSegmentAt: 2)
        
        genderTitle.snp.makeConstraints { make in
            make.top.equalTo(surnameInput.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(24)
        }
        if(gender == "Man"){
            segmentedControll.selectedSegmentIndex = 0
            view.addSubview(segmentedControll)
            segmentedControll.addTarget(self, action: #selector(textFieldChanged), for: .allEvents)
            segmentedControll.snp.makeConstraints { make in
            make.top.equalTo(genderTitle.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().offset(25)
            }
        }else if(gender == "Woman"){
            segmentedControll.selectedSegmentIndex = 1
            view.addSubview(segmentedControll)
            segmentedControll.addTarget(self, action: #selector(textFieldChanged), for: .allEvents)
            segmentedControll.snp.makeConstraints { make in
            make.top.equalTo(genderTitle.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().offset(25)
            }
        }else{
            segmentedControll.selectedSegmentIndex = 2
            view.addSubview(segmentedControll)
            segmentedControll.addTarget(self, action: #selector(textFieldChanged), for: .allEvents)
            segmentedControll.snp.makeConstraints { make in
            make.top.equalTo(genderTitle.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().offset(25)
            }
        }
    }
    
    func prepareRoomInput(){
        let inputTitle = getInputTitle(text : "Room")
        view.addSubview(inputTitle)
        inputTitle.snp.makeConstraints{ make in
            make.top.equalTo(segmentedControll.numberOfSegments).offset(380)
            make.leading.equalToSuperview().offset(24)
        }
        prepareInput(roomInput, placeholder: "Room 206")
        roomInput.text = "\(self.room)"
        roomInput.autocapitalizationType = .none
        roomInput.autocorrectionType = .no
        view.addSubview(roomInput)
        roomInput.snp.remakeConstraints{ make in
            make.top.equalTo(inputTitle.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
    }

    func prepareBedInput(){
        let inputTitle = getInputTitle(text : "Bed")
        view.addSubview(inputTitle)
        inputTitle.snp.makeConstraints{ make in
            make.top.equalTo(roomInput.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(24)
        }
        prepareInput(bedInput, placeholder: "Bed 3")
        bedInput.text = "\(self.bed)"
        bedInput.autocapitalizationType = .none
        bedInput.autocorrectionType = .no
        view.addSubview(bedInput)
        bedInput.snp.makeConstraints{ make in
            make.top.equalTo(inputTitle.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
    }
    
    func prepareInfoInput(){
        let inputTitle = getInputTitle(text : "Information")
        view.addSubview(inputTitle)
        inputTitle.snp.makeConstraints{ make in
            make.top.equalTo(bedInput.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(24)
        }
        prepareInput(patientInfo, placeholder: "Additional information")
        patientInfo.autocapitalizationType = .none
        patientInfo.autocorrectionType = .no
        patientInfo.text = "\(self.info)"
        view.addSubview(patientInfo)
        patientInfo.snp.remakeConstraints{ make in
            make.top.equalTo(inputTitle.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
    }

    
    func prepareAddPatientBUtton() {
        addPatientButton.setTitle("Update patient data!", for: .normal)
        addPatientButton.setTitleColor(.white, for: .normal)
        addPatientButton.setTitleColor(.white.withAlphaComponent(0.2), for: .disabled)
        addPatientButton.backgroundColor = blueColor
        addPatientButton.layer.borderWidth = 1
        addPatientButton.layer.cornerRadius = 30
        addPatientButton.layer.borderColor = UIColor(red: 237.0 / 255.0, green: 242.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0).cgColor
        addPatientButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        addPatientButton.addTarget(self, action: #selector(addPatient), for: .primaryActionTriggered)
        view.addSubview(addPatientButton)
        addPatientButton.snp.makeConstraints {make in
            make.leading.trailing.equalToSuperview().inset(60)
            self.buttonBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint.update(offset: -30)
            make.bottom.equalToSuperview().offset(0)
            make.height.equalTo(60)
        }
        addPatientButton.isEnabled = false
    }
    
    func prepareInput(_ textField: UITextField, placeholder: String?) {
        textField.placeholder = placeholder
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        textField.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
    }
    
    @objc open func textFieldChanged() {
        // MARK: - Login button is enabled when username and password is filled
        addPatientButton.isEnabled = nameInput.text?.isEmpty == false && roomInput.text?.isEmpty == false && bedInput.text?.isEmpty == false && surnameInput.text?.isEmpty == false && segmentedControll.selectedSegmentIndex != UISegmentedControl.noSegment
    }
    
    @objc open func addPatient(){
        view.endEditing(true)
        addPatientRequest()
    }
    
    func getGender(sender : UISegmentedControl) -> String{
        switch(sender.selectedSegmentIndex){
        case 0:
            return "Man"
        case 1:
            return "Woman"
        case 2:
            return "Other"
        default:
            break
        }
        return ""
    }

    func addPatientRequest(){

        let Patient = Patient(name: nameInput.text!, surname: surnameInput.text!, room: roomInput.text!, bed: bedInput.text!, patientInfo: patientInfo.text!, Gender: getGender(sender: segmentedControll), addedByUser: currentUser!, ID: userID)
        print("addPatientRequest")
        dataSource?.editPatient(patient: Patient)
        
        completeDS.updateDashboard(pacient: Patient)
        
        saveData(name: Patient.name, surname: Patient.surname, room: Patient.room, bed: Patient.bed, gender: Patient.Gender, patientInfo: Patient.patientInfo, addedByUser: Patient.addedByUser)
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    func saveData(name : String, surname : String, room : String, bed : String, gender : String, patientInfo : String, addedByUser : String){
        let db = Firestore.firestore()
        db.collection("Patients").document(self.userID).updateData(["name": name, "surname" : surname, "room" : room, "bed" : bed, "gender" : gender, "patient_info" : patientInfo, "added_by_user" : addedByUser]) { (err) in
            
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
        }
    }
}
