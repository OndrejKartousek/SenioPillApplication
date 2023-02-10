//
//  PatientProfileViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 23.06.2022.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import SnapKit

class PatientProfileViewController: UITableViewController{
    
    public var titleLabelView = LabelValueView(title: "Name")
    public var dataSource = PatientList()
    let currentUser = Auth.auth().currentUser?.uid

    //public var data : Patient?
    
    var roomLabel = UILabel()
    var bedLabel = UILabel()
    var descrptionLabel = UILabel()
    var genderLabel = UILabel()
    let comleteListDS = CompleteList.completeModel
    var assigments : [AssignedModel] = []
    let boldRoom = "Patient's room"
    let boldBed = "Patient's bed"
    let boldGender = "Gender"
    let boldDesc = "Information"
    
    var userID = ""
    
    open var data : Any? {
        didSet{
            if data != nil{
                updateView()
            }
        }
    }

    init(dataSource : PatientList){
        super.init(nibName: nil, bundle: nil)
        self.dataSource = dataSource
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    open func prepareView(){
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        prepareGenderLabel()
        prepareRoomLabel()
        prepareBedLabel()
        prepareDescLabel()
        }
    
    open func updateView(){
        guard let dataUnwrapped = data as? Patient else{
            return
        }
        userID = dataUnwrapped.ID ??  ""  
        assigments = comleteListDS.getUserAssignments(patientId: userID)
        roomLabel.text = "Patient's room : \(dataUnwrapped.room)"
        bedLabel.text = "Patient's bed : \(dataUnwrapped.bed)"
        descrptionLabel.text = "Patient's info : \(dataUnwrapped.patientInfo)"
        genderLabel.text = "Gender : \(dataUnwrapped.Gender)"
        self.title = "\(dataUnwrapped.name) \(dataUnwrapped.surname)"
        prepareTopImage(gender: dataUnwrapped.Gender)
    }
    
    func prepareTopImage(gender : String){
        if gender == "Man"{
            let image = UIImage(named: "man")
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
            imageView.snp.makeConstraints{ make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(0)
                make.centerX.equalToSuperview()
                make.height.equalTo(200)
                make.width.equalTo(200)
            }
        }else if gender == "Woman"{
            let image = UIImage(named: "woman")
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
            imageView.snp.makeConstraints{ make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(0)
                make.centerX.equalToSuperview()
                make.height.equalTo(200)
                make.width.equalTo(200)
            }
        }else{
            let image = UIImage(named: "helicopter")
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
            imageView.snp.makeConstraints{ make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(0)
                make.centerX.equalToSuperview()
                make.height.equalTo(200)
                make.width.equalTo(200)
            }
        }
    }
    
    func prepareGenderLabel(){
        view.addSubview(genderLabel)
        genderLabel.font = UIFont.boldSystemFont(ofSize: 20)
        genderLabel.numberOfLines = 1
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(250)
            make.leading.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func prepareRoomLabel(){
        view.addSubview(roomLabel)
        roomLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        roomLabel.snp.makeConstraints{make in
            make.top.equalTo(genderLabel).offset(50)
            make.leading.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func prepareBedLabel(){
        view.addSubview(bedLabel)
        bedLabel.font = UIFont.boldSystemFont(ofSize: 20)
        bedLabel.snp.makeConstraints { make in
            make.top.equalTo(roomLabel).offset(50)
            make.leading.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func prepareDescLabel(){
        view.addSubview(descrptionLabel)
        descrptionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        descrptionLabel.numberOfLines = 7
        descrptionLabel.snp.makeConstraints { make in
            make.top.equalTo(bedLabel).offset(50)
            make.leading.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func addTapped(){
        let assignADrug = DrugsAssignmentListVC(dataSource: dataSource.getPatient(id: userID) ?? nil)
        self.navigationController?.pushViewController(assignADrug, animated: true)
    }
}
