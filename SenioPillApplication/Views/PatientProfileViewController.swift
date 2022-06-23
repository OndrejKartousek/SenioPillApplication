//
//  PatientProfileViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 23.06.2022.
//

import Foundation
import UIKit

class PatientProfileViewController: UIViewController{
    
    public var titleLabelView = LabelValueView(title: "Název")
    public var dataSource = PatientList()

    //public var data : Patient?
    
    var roomLabel = UILabel()
    var bedLabel = UILabel()
    var descrptionLabel = UILabel()
    var image = UIImage(systemName: "person.circle")
    
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
        //self.title = "Detail pacienta"
        prepareTopImage()
        prepareRoomLabel()
        prepareBedLabel()
        prepareDescLabel()
    }
    
    open func updateView(){
        guard let dataUnwrapped = data as? Patient else{
            return
        }
        roomLabel.text = "Pokoj pacienta : \(dataUnwrapped.room)"
        bedLabel.text = "Lůžko pacienta : \(dataUnwrapped.bed)"
        descrptionLabel.text = "Informace o pacientovi : \(dataUnwrapped.patientInfo)"
        self.title = "\(dataUnwrapped.name) \(dataUnwrapped.surname)"
        //titleLabel.text = "\(dataUnwrapped.name) \(dataUnwrapped.surname)"
        //infoLabel.text = "Pokoj : \(dataUnwrapped.room) Lůžko : \(dataUnwrapped.bed) Poznámka : \(dataUnwrapped.patientInfo)"
    }
    
    func prepareTopImage(){
        let image = UIImage(named: "person")
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

    func prepareRoomLabel(){
        view.addSubview(roomLabel)
        roomLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        roomLabel.snp.makeConstraints{make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(250)
            make.leading.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func prepareBedLabel(){
        view.addSubview(bedLabel)
        bedLabel.font = UIFont.boldSystemFont(ofSize: 20)
        bedLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(300)
            make.leading.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func prepareDescLabel(){
        view.addSubview(descrptionLabel)
        descrptionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        descrptionLabel.numberOfLines = 7
        descrptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(350)
            make.leading.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    
}
