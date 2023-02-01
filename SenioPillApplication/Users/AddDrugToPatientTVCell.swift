//
//  DrugsListTVCell.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 21.06.2022.
//

import Foundation
import UIKit

public class AddDrugToPatientTVCell : UITableViewCell{
    
    open class var reuseIdentifier : String{
        return String(describing: Self.self)
    }
    
    var titleLabel = UILabel()
    var dosageLabel = UILabel()
    var infoLabel = UILabel()
    
    
    open var data : Any? {
        didSet{
            if data != nil{
                updateView()
            }
        }
    }
    override public init (style: UITableViewCell.CellStyle = .default, reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareView()
    }
    
    required init?(coder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func prepareView(){
        prepareTitleLabel()
        prepareDosageLabel()
        prepareInfoLabel()
    }

    open func updateView(){
        guard let dataUnwrapped = data as? Drugs else{
            return
        }
        
        titleLabel.text = "\(dataUnwrapped.name)"
        dosageLabel.text = "Dávkování \(dataUnwrapped.PrescriptedDosage)"
        infoLabel.text = "Info : \(dataUnwrapped.description)"
        //print(dataUnwrapped.name)
        //print(dataUnwrapped.description)
    }
    
    open func prepareTitleLabel(){
        titleLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .heavy)
        titleLabel.textColor = blueColor
        contentView.addSubview(titleLabel)
        titleLabel.snp.remakeConstraints{ (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.bottom.equalToSuperview().offset(-50)
            
        }
    }
    
    open func prepareDosageLabel(){
        contentView.addSubview(dosageLabel)
        dosageLabel.font = UIFont.boldSystemFont(ofSize: 16)
        dosageLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.bottom.equalToSuperview().offset(10)
            
        }
    }
    
    open func prepareInfoLabel(){
        infoLabel.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints{ (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.bottom.equalToSuperview().offset(50)
            
        }
    }
}
