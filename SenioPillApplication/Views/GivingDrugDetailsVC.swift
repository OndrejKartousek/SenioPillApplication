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

class GivingDrugDetailsVC : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    public var drugsDataSource = DrugsList()
    public var patientDataSource = PatientList()
    let giveDrugButton = UIButton()
    let dosageInput = BaseTextField()
    var dataSource: PatientList?
    let TimePickerTextField = UIDatePicker()
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

    var drugSelectorLabel = UILabel()
    var drugSelector = UIPickerView()


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
        prepareDosageInput()
        prepareTimeInput()
        
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
        // MARK: - Login button is enabled when username and password is filled
        //addPatientButton.isEnabled = nameInput.text?.isEmpty == false && roomInput.text?.isEmpty == false && bedInput.text?.isEmpty == false && surnameInput.text?.isEmpty == false && segmentedControll.selectedSegmentIndex != UISegmentedControl.noSegment
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 10
        } else {
            return 100
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "First \(row)"
        } else {
            return "Second \(row)"
        }
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
        TimePickerTextField.datePickerMode = .time
        TimePickerTextField.preferredDatePickerStyle = .compact
        view.addSubview(TimePickerTextField)
        TimePickerTextField.snp.makeConstraints { make in
            make.top.equalTo(dosageInput).offset(70)
            make.leading.equalToSuperview().offset(20)
        }

    }
    
    
    
    func prepareMondayInput(){
        view.addSubview(mondaySwitch)
        mondaySwitch.snp.makeConstraints { make in
            make.top.equalTo(TimePickerTextField).offset(50)
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
        tuesdaySwitch.snp.makeConstraints { make in
            make.top.equalTo(TimePickerTextField).offset(85)
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
        wednesdaySwitch.snp.makeConstraints { make in
            make.top.equalTo(TimePickerTextField).offset(120)
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
        thursdaySwitch.snp.makeConstraints { make in
            make.top.equalTo(TimePickerTextField).offset(155)
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
        fridaySwitch.snp.makeConstraints { make in
            make.top.equalTo(TimePickerTextField).offset(190)
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
        saturdaySwitch.snp.makeConstraints { make in
            make.top.equalTo(TimePickerTextField).offset(225)
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
        sundaySwitch.snp.makeConstraints { make in
            make.top.equalTo(TimePickerTextField).offset(260)
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
        //giveDrugButton.addTarget(self, action: #selector(addPatient), for: .primaryActionTriggered)
        view.addSubview(giveDrugButton)
        giveDrugButton.snp.makeConstraints {make in
            make.leading.trailing.equalToSuperview().inset(60)
            self.buttonBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint.update(offset: -30)
            make.bottom.equalToSuperview().offset(50)
            make.height.equalTo(60)
        }
        giveDrugButton.isEnabled = false
        
    }
    
}
