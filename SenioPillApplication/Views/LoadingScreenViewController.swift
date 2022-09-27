
//
//  LoadingScreenViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 17.06.2022.
//

import UIKit
import SnapKit

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
let mainGreenColor = UIColor(red: 129, green: 199, blue: 132)


class LoadingScreenViewController: UIViewController {

    let continueButton = UIButton()
    let switcherBetweenAgreements = UISwitch()
    var buttonBottomConstraint: Constraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        // Do any additional setup after loading the view.
    }
    
    open func prepareView(){
        view.backgroundColor = .white
        prepareTopImage()
        prepareLicenceAgreementText()
        prepareSwitcher()
        prepareContinueButton()
        
        
    }
    
    func prepareTopImage(){
        let image = UIImage(named: "SenioPill-logo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(0)
            make.centerX.equalToSuperview()
            make.height.equalTo(600)
            make.width.equalTo(600)
        }
    }
    func prepareLicenceAgreementText(){
        let label = UILabel()
        label.text = "Made by B2A Digital Inovation s.r.o"
        view.addSubview(label)
        label.snp.makeConstraints{make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(450)
            make.leading.equalToSuperview().offset(67)
            make.centerX.equalToSuperview()
        }
    }
    
    func prepareSwitcher(){
        
    }
    
    func prepareContinueButton(){
        continueButton.setTitle("Pokračovat", for: .normal)
        continueButton.setTitleColor(.black, for: .normal)
        continueButton.setTitleColor(.black.withAlphaComponent(0.7), for: .disabled)
        continueButton.backgroundColor = mainGreenColor
        continueButton.layer.borderWidth = 1
        continueButton.layer.cornerRadius = 30
        continueButton.layer.borderColor = UIColor(red: 237.0 / 255.0, green: 242.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0).cgColor
        continueButton.addTarget(self, action: #selector(performContinue), for: .primaryActionTriggered)
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview().inset(60)
            self.buttonBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint
            make.bottom.equalToSuperview().offset(50)
            make.height.equalTo(60)
        }
    }
    
    @objc open func performContinue(){
        let tabBarController = BaseTabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
