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
    }
    open func updateView(){
        guard let dataUnwrapped = data as? Patient else{
            return
        }
        titleLabel.text = "\(dataUnwrapped.name) \(dataUnwrapped.surname)"
    }
    
    open func prepareTitleLabel(){
        contentView.addSubview(titleLabel)
        titleLabel.snp.remakeConstraints{ (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.bottom.equalToSuperview()
        }
    }
}
