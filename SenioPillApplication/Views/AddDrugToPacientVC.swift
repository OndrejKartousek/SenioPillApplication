import Foundation
import UIKit
import SnapKit
import FirebaseAuth
import FirebaseFirestore


class AddDrugToPacientVC: UITableViewController{
    
    let currentUser = Auth.auth().currentUser?.uid
    
    public var dataSource = DrugsList()
    public var patientDataSource = PatientList()
    public var noDataLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        getDrugs()
        updateData()
    }
    
    func updateData(){
        tableView.reloadData()
        noDataLabel.isHidden = !dataSource.getDrugs().isEmpty
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateData()
    }
    
    open func prepareView(){
        view.backgroundColor = .white
        self.title = "Assign a drug"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        prepareTableView()
        prepareNoDataLabel()
    }
    
    func prepareNoDataLabel(){
        noDataLabel.isHidden = true
        noDataLabel.text = "No drugs added yet."
        tableView.addSubview(noDataLabel)
        noDataLabel.snp.makeConstraints{make in
            make.center.equalToSuperview()
        }
    }
    
    func prepareTableView() {
        tableView.register(AddDrugToPatientTVCell.self, forCellReuseIdentifier: AddDrugToPatientTVCell.description())
        tableView.rowHeight = 90
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = blueColor
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
        return dataSource.getDrugs().count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddDrugToPatientTVCell.description(), for: indexPath) as? AddDrugToPatientTVCell else {
            return UITableViewCell()
        }
        cell.data = dataSource.getDrugs()[indexPath.row]
        return cell
    }
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = GivenDrugDetailsVC(dataSource: patientDataSource)
        //vc.data = dataSource.getDrugs()[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addTapped() {
        let vc = GivenDrugDetailsVC(dataSource: patientDataSource)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func addClickedDrug(){
        let vc = GivenDrugDetailsVC(dataSource: patientDataSource)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    public func getDrugs(){
        let db = Firestore.firestore();
        let ref = db.collection("Drugs");
        ref.getDocuments{snapshot, error in
                         guard error == nil else {
            print(error!.localizedDescription)
            return
        }
            if let snapshot = snapshot {
                for document in snapshot.documents{
                    let data = document.data()
                    let drugName = data["name"] as? String ?? ""
                    let addedByUser = data["added_by_user"] as? String ?? ""
                    let drugDescription = data["description"] as? String ?? ""
                    let drugDosage = data["prescriptedDosage"] as? String ?? ""
                    if(addedByUser == self.currentUser!){
                        let DrugNew = Drugs(name: drugName, description: drugDescription, PrescriptedDosage: drugDosage, addedByUser: self.currentUser!)
                        self.dataSource.addDrug(drug: DrugNew)
                    }
                }
            }
        }
    }
}
