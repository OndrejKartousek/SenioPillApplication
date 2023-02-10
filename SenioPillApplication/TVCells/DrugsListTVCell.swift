//
//  DrugsListTVCell.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 21.06.2022.
//

import Foundation
import UIKit

public class DrugListTVCell : UITableViewCell{
    
    open class var reuseIdentifier : String{
        return String(describing: Self.self)
    }
    
    var titleLabel = UILabel()
    var dosageLabel = UILabel()
    var infoLabel = UILabel()
    var image = UIImage()
    
    
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
        prepareImage()
        prepareTitleLabel()
        prepareDosageLabel()
        prepareInfoLabel()
    }

    open func updateView(){
        guard let dataUnwrapped = data as? Drugs else{
            return
        }
        
        titleLabel.text = "\(dataUnwrapped.name)"
        dosageLabel.text = "Dosage \(dataUnwrapped.PrescriptedDosage)"
        infoLabel.text = "Information : \(dataUnwrapped.description)"
    }
    
    func prepareImage(){
        var n = Int.random(in: 1...3)
        if n == 1{
            let image = UIImage(named: "drugs")
            let imageView = UIImageView(image: image)
            imageView.tintColor = .black
            imageView.contentMode = .scaleAspectFit
            contentView.addSubview(imageView)
            imageView.snp.makeConstraints{ make in
                make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(8)
                make.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading).offset(10)
                make.height.equalTo(75)
                make.width.equalTo(75)
            }
        }else if n == 2{
            let image = UIImage(named: "drugs2")
            let imageView = UIImageView(image: image)
            imageView.tintColor = .black
            imageView.contentMode = .scaleAspectFit
            contentView.addSubview(imageView)
            imageView.snp.makeConstraints{ make in
                make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(8)
                make.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading).offset(10)
                make.height.equalTo(75)
                make.width.equalTo(75)
            }
        }else{
            let image = UIImage(named: "drugs3")
            let imageView = UIImageView(image: image)
            imageView.tintColor = .black
            imageView.contentMode = .scaleAspectFit
            contentView.addSubview(imageView)
            imageView.snp.makeConstraints{ make in
                make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(8)
                make.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading).offset(10)
                make.height.equalTo(75)
                make.width.equalTo(75)
            }
        }
        
    }
    
    open func prepareTitleLabel(){
        titleLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .heavy)
        titleLabel.textColor = blueColor
        contentView.addSubview(titleLabel)
        titleLabel.snp.remakeConstraints{ (make) in
            make.leading.equalToSuperview().offset(90)
            make.trailing.equalToSuperview().offset(-20)
            make.height.bottom.equalToSuperview().offset(-50)
            
        }
    }
    
    open func prepareDosageLabel(){
        contentView.addSubview(dosageLabel)
        dosageLabel.font = UIFont.boldSystemFont(ofSize: 16)
        dosageLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(90)
            make.trailing.equalToSuperview().offset(-20)
            make.height.bottom.equalToSuperview().offset(10)
            
        }
    }
    
    open func prepareInfoLabel(){
        infoLabel.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints{ (make) in
            make.leading.equalToSuperview().offset(90)
            make.trailing.equalToSuperview().offset(-20)
            make.height.bottom.equalToSuperview().offset(50)
            
        }
    }
}
