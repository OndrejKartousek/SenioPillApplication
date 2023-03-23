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
    
    public var completeDataSource = CompleteList.completeModel
    public var titleLabelView = LabelValueView(title: "Name")
    public var dataSource = PatientList()
    let currentUser = Auth.auth().currentUser?.uid
    var assigments : [AssignedModel] = []
    var gender = ""
    public var noDataLabel = UILabel()
    let headerImageView = UIImageView()


    let patientNameLabel = UILabel(frame: CGRect.init(x: 10, y: 0, width: 300, height: 200))
    let roomLabel = UILabel(frame: CGRect.init(x: 10, y: 0, width: 300, height: 200))
    let genderLabel = UILabel(frame: CGRect.init(x: 10, y: 0, width: 300, height: 200))
    let decriptionLabel = UILabel(frame: CGRect.init(x: 10, y: 0, width: 300, height: 200))
    let daysLabel = UILabel()
    
    var monday = "Monday"
    var tuesday = "Tuesday"
    var wednesday = "Wednesday"
    var thursday = "Thursday"
    var friday = "Friday"
    var saturday = "Saturday"
    var sunday = "Sunday"
    
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
        prepareTableView()
    }
    func updateData(){
        tableView.reloadData()
        noDataLabel.isEnabled = !assigments.isEmpty
    }
    
    func prepareTableView(){
        tableView.register(PatientTVCell.self, forCellReuseIdentifier: PatientTVCell.description())
        tableView.rowHeight = 100
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = blueColor
    }
    
    func prepareNoDataLabel(){
        noDataLabel.isHidden = true
        noDataLabel.text = "No data added yet."
        tableView.addSubview(noDataLabel)
        noDataLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    open func updateView(){
        guard let dataUnwrapped = data as? Patient else{
            return
        }
        self.userID = dataUnwrapped.ID ?? ""
        self.assigments = completeDataSource.getUserAssignments(patientId: dataUnwrapped.ID ?? "")
        patientNameLabel.text = "\(dataUnwrapped.name) \(" ")\(dataUnwrapped.surname)"
        genderLabel.text = "Gender : \(dataUnwrapped.Gender)"
        roomLabel.text = "Room : \(dataUnwrapped.room) \(" Bed") \(dataUnwrapped.bed)"
        decriptionLabel.text = "Info : \(dataUnwrapped.patientInfo)"
        daysLabel.text = "Days : "
        gender = dataUnwrapped.Gender
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
            headerView.backgroundColor = .white
        
        if gender == "Man"{
            headerImageView.image = UIImage(named: "man")
            headerImageView.contentMode = .scaleAspectFit
            headerView.addSubview(headerImageView)
            headerImageView.snp.makeConstraints{ make in
                make.top.equalToSuperview().offset(5)
                make.centerX.equalToSuperview()
                make.height.equalTo(100)
                make.width.equalTo(100)
            }
        }else if gender == "Woman"{
            headerImageView.image = UIImage(named: "woman")
            headerImageView.contentMode = .scaleAspectFit
            headerView.addSubview(headerImageView)
            headerImageView.snp.makeConstraints{ make in
                make.top.equalToSuperview().offset(5)
                make.centerX.equalToSuperview()
                make.height.equalTo(100)
                make.width.equalTo(100)
            }
        }else{
                headerImageView.image = UIImage(named: "helicopter")
                headerImageView.contentMode = .scaleAspectFit
                headerView.addSubview(headerImageView)
                headerImageView.snp.makeConstraints{ make in
                    make.top.equalToSuperview().offset(5)
                    make.centerX.equalToSuperview()
                    make.height.equalTo(100)
                    make.width.equalTo(100)
            }
        }
        
        patientNameLabel.textColor = .black
        patientNameLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .heavy)

        headerView.addSubview(patientNameLabel)
        patientNameLabel.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(110)
        }
        
        genderLabel.textColor = .black
        genderLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        headerView.addSubview(genderLabel)
            genderLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(patientNameLabel).offset(30)
        }
        
        roomLabel.textColor = .black
        headerView.addSubview(roomLabel)
        roomLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        roomLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(genderLabel).offset(20)
        }
        
        decriptionLabel.textColor = .black
        decriptionLabel.lineBreakMode = .byTruncatingMiddle
        decriptionLabel.numberOfLines = 5
        headerView.addSubview(decriptionLabel)
        decriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(roomLabel).offset(20)
        }
        
        return headerView
    }
    

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 250
        }
    
    open override func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return assigments.count
    }
    
    open override func tableView(_ tableView : UITableView, cellForRowAt IndexPath : IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: PatientTVCell.description(), for: IndexPath) as? PatientTVCell
        else{
            return UITableViewCell()
        }
        cell.data = assigments[IndexPath.row]
        return cell
    }
    
    open override func tableView(_ tableView : UITableView, didSelectRowAt indexPath : IndexPath){
    }
    
    open override func tableView(_ tableView: UITableView, canEditRowAt indexPath : IndexPath) -> Bool{
        return true
    }
    
    open override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let id = assigments[indexPath[1]].ID
            print(("ID : \(id)"))
            deleteData(id: id)
            completeDataSource.deleteById(id: id)
            assigments.removeAll(where: {$0.ID == id})
            updateData()
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    open func prepareView(){
        view.backgroundColor = .white
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped)),
            UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))]
    }
    
    @objc func addTapped(){
        let assignADrug = DrugsAssignmentListVC(dataSource: dataSource.getPatient(id: userID) ?? nil)
        self.navigationController?.pushViewController(assignADrug, animated: true)
    }
    
    @objc func edit(){
        let vc = EditPatientVC(dataSource:dataSource)
        print(completeDataSource.getConcreteData(id: userID))
        vc.data = dataSource.getPatient(id: userID)
        vc.completeData = completeDataSource.getConcreteData(id: userID)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func deleteData(id : String){
        let db = Firestore.firestore()
        db.collection("AssignedDrugs").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
