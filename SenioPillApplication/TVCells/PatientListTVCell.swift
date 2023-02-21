//
//  PatientListTVCell.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 21.06.2022.
//

import Foundation
import UIKit

public class PatientListTVCell: UITableViewCell{
    
    var titleLabel = UILabel()
    var roomLabel = UILabel()
    var bedLabel = UILabel()
    var descriptionLabel = UILabel()
    var newColor = UIColor.lightGray.cgColor
    var bool = false
    
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
    
    override public init (style: UITableViewCell.CellStyle = .default, reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareView()
    }
    
    required init?(coder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func prepareView(){
        prepareTitleLabel()
        prepareRoomLabel()
        prepareBedLabel()
        prepareDescriptionLabel()
    }
    open func updateView(){
        guard let dataUnwrapped = data as? Patient else{
            return
        }
        
        titleLabel.text = "\(dataUnwrapped.name) \(dataUnwrapped.surname)"
        roomLabel.text = "Room : \(dataUnwrapped.room)"
        bedLabel.text = "Bed : \(dataUnwrapped.bed)"
        descriptionLabel.text = "Information : \(dataUnwrapped.patientInfo)"
        prepareImage(gender: dataUnwrapped.Gender)
        }
    func prepareImage(gender : String){
            if gender == "Man"{
                let image = UIImage(named: "man")
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                contentView.addSubview(imageView)
                imageView.snp.makeConstraints{ make in
                    make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(8)
                    make.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading).offset(10)
                    make.height.equalTo(100)
                    make.width.equalTo(100)
                }
            }
            else if gender == "Woman"{
                let image = UIImage(named: "woman")
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                contentView.addSubview(imageView)
                imageView.snp.makeConstraints{ make in
                    make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(8)
                    make.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading).offset(10)
                    make.height.equalTo(100)
                    make.width.equalTo(100)
                }
            }
            else if gender == "Other"{
                let image = UIImage(named: "helicopter")
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                contentView.addSubview(imageView)
                imageView.snp.makeConstraints{ make in
                    make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(8)
                    make.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading).offset(10)
                    make.height.equalTo(100)
                    make.width.equalTo(100)
            }
        }
    }
    
    open func prepareTitleLabel(){
        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .heavy)
        titleLabel.backgroundColor = .white
        titleLabel.textColor = blueColor
        titleLabel.snp.remakeConstraints{ (make) in
            make.leading.equalToSuperview().offset(125)
            make.trailing.equalToSuperview().offset(-20)
            make.height.bottom.equalToSuperview().offset(-80)
        }
    }
    open func prepareRoomLabel(){
        contentView.addSubview(roomLabel)
        roomLabel.font = UIFont.boldSystemFont(ofSize: 16)
        roomLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(125)
            make.trailing.equalToSuperview().offset(-20)
            make.height.bottom.equalToSuperview().offset(-25)
        }
    }
    
    open func prepareBedLabel(){
        contentView.addSubview(bedLabel)
        bedLabel.font = UIFont.boldSystemFont(ofSize: 16)
        bedLabel.snp.makeConstraints{ (make) in
            make.leading.equalToSuperview().offset(125)
            make.trailing.equalToSuperview().offset(-20)
            make.height.bottom.equalToSuperview().offset(25)
        }
    }
    
    open func prepareDescriptionLabel(){
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(125)
            make.trailing.equalToSuperview().offset(-20)
            make.height.bottom.equalToSuperview().offset(70)
        }
    }
}
