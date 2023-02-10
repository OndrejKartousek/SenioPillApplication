//
//  PatientsDrugsTVCell.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 10.02.2023.
//

import Foundation
import UIKit

class PatientsDrugsTVCell : UITableViewCell{
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
        prepareDrugNameLabel()
        prepareTimeLabel()
    }
    
    open func updateView(){
        guard let dataUnwrapped = data as? AssignedModel else{
            return
        }
        
        drugName.text = "\(dataUnwrapped.drugName)"
        time.text = "\(dataUnwrapped.givenDrugHour) \(":")\(dataUnwrapped.givenDrugMinute)"
        
    }
    
    func prepareDrugNameLabel(){
        drugName.font = UIFont.systemFont(ofSize: 25.0, weight: .heavy)
        contentView.addSubview(drugName)
        drugName.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    func prepareTimeLabel(){
        time.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(time)
        time.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(20)
        }
    }
}
