//
//  DashboardListTVCell.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 08.02.2023.
//

import Foundation
import UIKit

public class DashboardListTVCell : UITableViewCell{
    var patientName = UILabel()
    var drugName = UILabel()
    
    var day = UILabel()
    var time = UILabel()
    
    open var data : Any? {
        didSet{
            if data != nil{
                updateView()
            }
        }
    }
    
    override public init(style : UITableViewCell.CellStyle = .default, reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareView()
    }
    
    required init?(coder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func prepareView(){
        prepareNameLabel()
        prepareDrugNameLabel()
    }
    
    open func updateView(){
        guard let dataUnwrapped = data as? AssignedModel else{
            return
        }
        
        patientName.text = "\(dataUnwrapped.patientName)\(dataUnwrapped.patientSurname)"
        drugName.text = "\(dataUnwrapped.drugName)"
        time.text = "\(dataUnwrapped.givenDrugHour) \(":")\(dataUnwrapped.givenDrugMinute)"
        
    }
    
    func prepareNameLabel(){
        patientName.font = UIFont.systemFont(ofSize: 25.0, weight: .heavy)
        patientName.textColor = blueColor
        contentView.addSubview(patientName)
        patientName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(20)
        }
    }
    
    func prepareDrugNameLabel(){
        drugName.font = UIFont.boldSystemFont(ofSize: 16)
        drugName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(20)
        }
    }
    
    func prepareTimeLabel(){
        time.font = UIFont.boldSystemFont(ofSize: 16)
        time.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(20)
        }
    }
}
