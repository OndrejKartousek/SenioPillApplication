//
//  DrugsInfoProfileViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 23.06.2022.
//

import Foundation
import UIKit

class DrugsInfoViewController: UIViewController{
    
    public var titleLabelView = LabelValueView(title: "Název")
    public var dataSource = DrugsList()

    //public var data : Patient?
    
    var dosageLabel = UILabel()
    var InfoLabel = UILabel()
    var image = UIImage(systemName: "pills")
    
    open var data : Any? {
        didSet{
            if data != nil{
                updateView()
            }
            
        }
    }

    init(dataSource : DrugsList){
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
        prepareInfoLabel()
        prepareDosageLabel()
    }
    
    open func updateView(){
        guard let dataUnwrapped = data as? Drugs else{
            return
        }
        dosageLabel.text = "Doporučené dávkování : \(dataUnwrapped.PrescriptedDosage)"
        InfoLabel.text = "Informace k léku : \(dataUnwrapped.description)"
        self.title = "\(dataUnwrapped.name)"
        //titleLabel.text = "\(dataUnwrapped.name) \(dataUnwrapped.surname)"
        //infoLabel.text = "Pokoj : \(dataUnwrapped.room) Lůžko : \(dataUnwrapped.bed) Poznámka : \(dataUnwrapped.patientInfo)"
    }
    
    func prepareTopImage(){
        let image = UIImage(named: "drugs")
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

    func prepareDosageLabel(){
        view.addSubview(dosageLabel)
        dosageLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        dosageLabel.numberOfLines = 3
        dosageLabel.snp.makeConstraints{make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(250)
            make.leading.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func prepareInfoLabel(){
        view.addSubview(InfoLabel)
        InfoLabel.font = UIFont.boldSystemFont(ofSize: 20)
        InfoLabel.numberOfLines = 7
        InfoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(300)
            make.leading.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    
    
}
