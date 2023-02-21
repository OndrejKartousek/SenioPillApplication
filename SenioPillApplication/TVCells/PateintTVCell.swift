//
//  PateintTVCell.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 14.02.2023.
//

import Foundation
import UIKit

public class PatientTVCell : UITableViewCell{
    
    var drugName = UILabel()
    var day = UILabel()
    var time = UILabel()
    var dosage = UILabel()
    
    let separatorView: UIView = {
       let view = UIView()
       view.backgroundColor = .lightGray
       return view
     }()
    
    open var data : Any? {
        didSet{
            if data != nil{
                updateView()
            }
        }
    }
    
    open class var reuseIdentifier : String{
        return String(describing: Self.self)
    }
    
    override public init(style : UITableViewCell.CellStyle = .default, reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareView()
        updateView()
    }
    
    required init?(coder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func prepareView(){
        prepareDrugNameLabel()
        prepareTimeLabel()
        prepareDosageLabel()
        updateView()
        
    }
    
    open func updateView(){
        guard let dataUnwrapped = data as? AssignedModel else{
            return
        }
        drugName.text = "\(dataUnwrapped.drugName)"
        if(dataUnwrapped.givenDrugMinute < 10){
            time.text = "\(dataUnwrapped.givenDrugHour) \(": 0")\(dataUnwrapped.givenDrugMinute)"
        }else{
            time.text = "\(dataUnwrapped.givenDrugHour) \(": ")\(dataUnwrapped.givenDrugMinute)"
        }
        dosage.text = "dosage : \(dataUnwrapped.givenDrugDosage)"

    }
    
    func prepareDrugNameLabel(){
        drugName.font = UIFont.systemFont(ofSize: 25.0, weight: .heavy)
        drugName.textColor = blueColor
        contentView.addSubview(drugName)
        drugName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(130)
        }
    }
    
    func prepareDosageLabel(){
        dosage.font = UIFont.systemFont(ofSize: 16,weight: .bold)
        contentView.addSubview(dosage)
        dosage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(45)
            make.leading.equalToSuperview().offset(130)
        }
    }
    
    func prepareTimeLabel(){
        time.font = UIFont.systemFont(ofSize: 30, weight: .thin)
        time.textAlignment = .center
        contentView.addSubview(time)
        time.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(20)
        }
    }
}

