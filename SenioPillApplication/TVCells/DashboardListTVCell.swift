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
    var gender = ""
    var room = UILabel()
    var bed = UILabel()
    var dosage = UILabel()
    var date = UILabel()
    
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
        prepareNameLabel()
        prepareDrugNameLabel()
        prepareTimeLabel()
        prepareRoomLabel()
        prepareBedLabel()
        prepareDosageLabel()
        prepareDateLabel()
        updateView()
        
    }
    
    open func updateView(){
        guard let dataUnwrapped = data as? AssignedModel else{
            return
        }
        gender = dataUnwrapped.Gender
        patientName.text = "\(dataUnwrapped.patientName) \(" ")\(dataUnwrapped.patientSurname)"
        drugName.text = "\(dataUnwrapped.drugName)"
        if dataUnwrapped.givenDrugMinute < 10{
            time.text = "\(dataUnwrapped.givenDrugHour) \(": 0")\(dataUnwrapped.givenDrugMinute)"

        }else{
            time.text = "\(dataUnwrapped.givenDrugHour) \(": ")\(dataUnwrapped.givenDrugMinute)"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        room.text = "room : \(dataUnwrapped.patientRoom)"
        bed.text = "bed : \(dataUnwrapped.patientBed)"
        dosage.text = "dosage : \(dataUnwrapped.givenDrugDosage)"
        date.text = dateFormatter.string(from: dataUnwrapped.nextDateToGive)
        //dateFormatter.string(from: dataUnwrapped.nextDateToGive)
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
    
    func prepareNameLabel(){
        patientName.font = UIFont.systemFont(ofSize: 25.0, weight: .heavy)
        patientName.textColor = blueColor
        contentView.addSubview(patientName)
        patientName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(130)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    
    func prepareRoomLabel(){
        room.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        contentView.addSubview(room)
        room.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(45)
            make.leading.equalToSuperview().offset(130)
        }
    }
    
    func prepareBedLabel(){
        bed.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        contentView.addSubview(bed)
        bed.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(45)
            make.leading.equalTo(room).offset(100)
        }
    }
    func prepareDrugNameLabel(){
        drugName.font = UIFont.systemFont(ofSize: 25.0, weight: .heavy)
        drugName.textColor = blueColor
        contentView.addSubview(drugName)
        drugName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(115)
            make.leading.equalToSuperview().offset(130)
        }
    }
    
    func prepareDosageLabel(){
        dosage.font = UIFont.systemFont(ofSize: 16,weight: .bold)
        contentView.addSubview(dosage)
        dosage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(145)
            make.leading.equalToSuperview().offset(130)
        }
    }
    
    func prepareTimeLabel(){
        time.font = UIFont.systemFont(ofSize: 30, weight: .thin)
        time.textAlignment = .center
        contentView.addSubview(time)
        time.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    func prepareDateLabel(){
        date.font = UIFont.systemFont(ofSize: 30, weight: .thin)
        date.textAlignment = .center
        contentView.addSubview(date)
        date.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(120)
        }
    }
}
