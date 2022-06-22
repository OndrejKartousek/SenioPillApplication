//
//  AddPatientViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 20.06.2022.
//

import Foundation
import UIKit
import SnapKit

class AddPatientViewController : UIViewController {

    let addPatientButton = UIButton()
    let nameInput = BaseTextField()
    let surnameInput = BaseTextField()
    let roomInput = BaseTextField()
    let bedInput = BaseTextField()
    let patientInfo = BaseTextField()

    var buttonBottomConstraint : Constraint!
    var dataSource: PatientList?
    let mainGreenColor = UIColor(rgb: 0xA9FFBA)

    init(dataSource: PatientList){
        super.init(nibName: nil, bundle: nil)
        self.dataSource = dataSource
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareNameInput()
        prepareSurnameInput()
        prepareRoomInput()
        prepareBedInput()
        prepareInfoInput()
        prepareAddPatientBUtton()
        //let patient = Patient(id: 1, name: "Jméno", surname: "Příjmení", room: "Pokoj 206", bed: "Lůžko 3", patientInfo: "yy")
        //dataSource?.addPatient(patient: patient)
    }
    
    open func prepareView(){
        self.title = "Přidat pacienta"
        view.backgroundColor = .white
    }
    
    func getInputTitle(text: String?) -> UILabel {
        let inputTitle = UILabel()
        inputTitle.text = text
        inputTitle.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return inputTitle
    }
    
    func prepareNameInput(){
        let inputTitle = getInputTitle(text : "Jméno")
        view.addSubview(inputTitle)
        inputTitle.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalToSuperview().offset(24)
        }
        prepareInput(nameInput, placeholder: "Jméno pacienta")
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
        let inputTitle = getInputTitle(text : "Příjmení")
        view.addSubview(inputTitle)
        inputTitle.snp.makeConstraints{ make in
            make.top.equalTo(nameInput.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        prepareInput(surnameInput, placeholder: "Příjmení pacienta")
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
    
    
    func prepareRoomInput(){
        let inputTitle = getInputTitle(text : "Pokoj")
        view.addSubview(inputTitle)
        inputTitle.snp.makeConstraints{ make in
            make.top.equalTo(surnameInput.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        prepareInput(roomInput, placeholder: "Pokoj 206")
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
        let inputTitle = getInputTitle(text : "Lůžko")
        view.addSubview(inputTitle)
        inputTitle.snp.makeConstraints{ make in
            make.top.equalTo(roomInput.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        prepareInput(bedInput, placeholder: "Lůžko 3")
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
        let inputTitle = getInputTitle(text : "Informace")
        view.addSubview(inputTitle)
        inputTitle.snp.makeConstraints{ make in
            make.top.equalTo(bedInput.snp.bottom).offset(20)//(self.view.safeAreaLayoutGuide.snp.top).offset(270)
            make.leading.equalToSuperview().offset(24)
        }
        prepareInput(patientInfo, placeholder: "Handicap, nesoběstačný")
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
        addPatientButton.setTitle("Přidat pacienta!", for: .normal)
        addPatientButton.setTitleColor(.black, for: .normal)
        addPatientButton.setTitleColor(.black.withAlphaComponent(0.2), for: .disabled)
        addPatientButton.backgroundColor = mainGreenColor
        addPatientButton.layer.borderWidth = 1
        addPatientButton.layer.cornerRadius = 30
        addPatientButton.layer.borderColor = UIColor(red: 237.0 / 255.0, green: 242.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0).cgColor
        addPatientButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        addPatientButton.addTarget(self, action: #selector(addPatient), for: .primaryActionTriggered)
        view.addSubview(addPatientButton)
        addPatientButton.snp.makeConstraints {make in
            make.leading.trailing.equalToSuperview().inset(60)
            self.buttonBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint.update(offset: -30)
            make.bottom.equalToSuperview().offset(50)
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
        addPatientButton.isEnabled = nameInput.text?.isEmpty == false && roomInput.text?.isEmpty == false && bedInput.text?.isEmpty == false && surnameInput.text?.isEmpty == false
    }
    
    @objc open func addPatient(){
        view.endEditing(true)
        addPatientRequest()
    }
    
    func addPatientRequest(){
        let pacient = Patient(id: 1, name: nameInput.text!, surname: surnameInput.text!, room: roomInput.text!, bed: bedInput.text!, patientInfo: patientInfo.text!)
        dataSource?.addPatient(patient: pacient)
        PatientViewController.isEmpty = false
        print(PatientViewController.isEmpty)
        
        //let vc = PatientViewController()
        _ = navigationController?.popToRootViewController(animated: true)

        //PatientList.shared.setPatientList(patient: pacient)
        //prepareInput(patientInfo , placeholder: pacient.name)
        
    }
    

    
}
