//
//  AddPatientViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 20.06.2022.
//

import Foundation
import UIKit
import SnapKit
import FirebaseFirestore
import FirebaseAuth

class AddPatientViewController: UIViewController, UIScrollViewDelegate {
    
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
    let blueColor = UIColor(red: 24, green: 146, blue: 250)

    
    init(dataSource: PatientList){
        super.init(nibName: nil, bundle: nil)
        self.dataSource = dataSource
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var scrollView: UIScrollView = {
         let scroll = UIScrollView()
         scroll.translatesAutoresizingMaskIntoConstraints = false
         scroll.delegate = self
         scroll.contentSize = CGSize(width: self.view.frame.size.width, height: 1000)
         return scroll
     }()
    
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
        view.addSubview(segmentedControll)
        segmentedControll.addTarget(self, action: #selector(textFieldChanged), for: .allEvents)
        segmentedControll.snp.makeConstraints { make in
            make.top.equalTo(genderTitle.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().offset(25)
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
        view.addSubview(patientInfo)
        patientInfo.snp.remakeConstraints{ make in
            make.top.equalTo(inputTitle.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
    }

    
    func prepareAddPatientBUtton() {
        addPatientButton.setTitle("Add patient!", for: .normal)
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
        let db = Firestore.firestore()
        let ref = db.collection("Patients").document()
        let Patient = Patient(name: nameInput.text!, surname: surnameInput.text!, room: roomInput.text!, bed: bedInput.text!, patientInfo: patientInfo.text!, Gender: getGender(sender: segmentedControll), addedByUser: currentUser!, ID: ref.documentID)
        dataSource?.addPatient(patient: Patient)
        
        ref.setData(["name": Patient.name, "surname" : Patient.surname, "room" : Patient.room, "bed" : Patient.bed, "gender" : Patient.Gender, "patient_info" : Patient.patientInfo, "added_by_user" : Patient.addedByUser]) { (err) in
            
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
        }
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    func saveData(name : String, surname : String, room : String, bed : String, gender : String, patientInfo : String, addedByUser : String){
     

    }
}
