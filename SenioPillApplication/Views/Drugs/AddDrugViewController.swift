import Foundation
import UIKit
import SnapKit
import FirebaseFirestore
import FirebaseAuth

class AddDrugViewController : UIViewController {

    
    let currentUser = Auth.auth().currentUser?.uid
    
    let addDrugButton = UIButton()
    
    let nameInput = BaseTextField()
    let DescriptionInput = BaseTextField()
    let PrescriptedDosage = BaseTextField()
    var dataSource: DrugsList?

    var buttonBottomConstraint : Constraint!
    
    let blueColor = UIColor(red: 24, green: 146, blue: 250)

    init(dataSource: DrugsList){
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
        prepareDescriptionInput()
        preparePrescriptedDosageInput()
        prepareAddDrugBUtton()
        addDrugButton.isEnabled = false
    }
    
    open func prepareView(){
        self.title = "Add drug"
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
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalToSuperview().offset(24)
        }
        
        prepareInput(nameInput, placeholder: "Drug name")
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
    
    func prepareDescriptionInput(){
        let inputTitle = getInputTitle(text : "Description")
        view.addSubview(inputTitle)
        inputTitle.snp.makeConstraints{ make in
            make.top.equalTo(nameInput.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        
        prepareInput(DescriptionInput, placeholder: "Short description")
        DescriptionInput.autocapitalizationType = .none
        DescriptionInput.autocorrectionType = .no
        view.addSubview(DescriptionInput)
        DescriptionInput.snp.remakeConstraints{ make in
            make.top.equalTo(inputTitle.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
    }
    
    func preparePrescriptedDosageInput(){
        let inputTitle = getInputTitle(text : "Dosage")
        view.addSubview(inputTitle)
        inputTitle.snp.makeConstraints{ make in
            make.top.equalTo(DescriptionInput.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        prepareInput(PrescriptedDosage, placeholder: "Recommended dosage")
        PrescriptedDosage.autocapitalizationType = .none
        PrescriptedDosage.autocorrectionType = .no
        view.addSubview(PrescriptedDosage)
        PrescriptedDosage.snp.remakeConstraints{ make in
            make.top.equalTo(inputTitle.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
    }

    func prepareAddDrugBUtton() {
        addDrugButton.setTitle("Add drug!", for: .normal)
        addDrugButton.setTitleColor(.white, for: .normal)
        addDrugButton.setTitleColor(.white.withAlphaComponent(0.2), for: .disabled)
        addDrugButton.backgroundColor = blueColor
        addDrugButton.layer.borderWidth = 1
        addDrugButton.layer.cornerRadius = 30
        addDrugButton.layer.borderColor = UIColor(red: 237.0 / 255.0, green: 242.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0).cgColor
        addDrugButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        addDrugButton.addTarget(self, action: #selector(addDrug), for: .primaryActionTriggered)
        view.addSubview(addDrugButton)
        addDrugButton.snp.makeConstraints {make in
            make.leading.trailing.equalToSuperview().inset(60)
            self.buttonBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint.update(offset: -30)
            make.bottom.equalToSuperview().offset(50)
            make.height.equalTo(60)
        }
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
        addDrugButton.isEnabled = nameInput.text?.isEmpty == false && PrescriptedDosage.text?.isEmpty == false
    }
    
    @objc open func addDrug(){
        view.endEditing(true)
        addDrugRequest()
    }
    
    func addDrugRequest(){
        var n = Int.random(in: 1...3)

        let Drug = Drugs(name: nameInput.text!, description: DescriptionInput.text!, PrescriptedDosage: PrescriptedDosage.text!, addedByUser: currentUser!, ID: "", randomInt: n)
        dataSource?.addDrug(drug: Drug)
        //(Drug)
        
        saveData(name: Drug.name, description: Drug.description, prescriptedDosage: Drug.PrescriptedDosage, addedByUser: Drug.addedByUser, randomInt: Drug.randomInt)
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    
    func saveData(name : String, description : String, prescriptedDosage : String, addedByUser : String, randomInt : Int){
        let db = Firestore.firestore()
        
        db.collection("Drugs").document().setData(["name": name, "description" : description, "prescriptedDosage" : prescriptedDosage, "added_by_user" : addedByUser, "randomInt" : randomInt]) { (err) in
            
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
        }
    }
    
}
