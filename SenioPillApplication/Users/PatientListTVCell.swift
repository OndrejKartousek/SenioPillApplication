//
//  PatientListTVCell.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 21.06.2022.
//

import Foundation
import UIKit

public class PatientListTVCell : UITableViewCell{
    
    open class var reuseIdentifier : String{
        return String(describing: Self.self)
    }
    
    
    var titleLabel = UILabel()
    var infoLabel = UILabel()
    var emptyPage = UILabel()
    
    
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
        prepareInfoLabel()
        prepareEmptyPageTitle()
    }
    open func updateView(){
        guard let dataUnwrapped = data as? Patient else{
            return
        }
        
        titleLabel.text = "\(dataUnwrapped.name) \(dataUnwrapped.surname)"
        infoLabel.text = "Pokoj : \(dataUnwrapped.room) Lůžko : \(dataUnwrapped.bed) Poznámka : \(dataUnwrapped.patientInfo)"
    }
    
    open func prepareEmptyPageTitle(){
        contentView.addSubview(emptyPage)
        emptyPage.text = "Zatím nebyli přidáni žádní pacienti"
        emptyPage.snp.makeConstraints{make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(350)
            make.leading.equalToSuperview().offset(67)
            make.centerX.equalToSuperview()
        }
        if(PatientViewController.isEmpty == true){
            emptyPage.isHidden = false
        }else{
            emptyPage.isHidden = true
            
        }
        
    }
    
    open func prepareTitleLabel(){
        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleLabel.snp.remakeConstraints{ (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.bottom.equalToSuperview().offset(-30)
            
        }
    }
    
    open func prepareInfoLabel(){
        contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints{ (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.bottom.equalToSuperview().offset(30)
            
        }
    }
}
