//
//  UserProfileViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 19.12.2022.
//

import UIKit
import SnapKit
class UserProfileViewController: UIViewController {

    var bottomConstraint : Constraint!
    private let logoutButton = CustomButton(title: "Logout",hasBackground: true, fontSize: .big)
    
    private let usernameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Loading..."
        label.numberOfLines = 2
        return label
    }()
    
    private let emailLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "Loading..."
        label.numberOfLines = 2
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareTopImage()
        prepareUsernameLabel()
        prepareEmailLabel()
        prepareLogoutButton()
        self.logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        
        AuthService.shared.fetchUser{[weak self] user, error in
            guard let self = self else {return}
            if let error = error{
                AlertManager.showFetchingUserError(on: self, with: error)
            }
            
            if let user = user{
                self.usernameLabel.text = "\(user.username)"
                self.emailLabel.text = "\(user.email)"
                
            }
        }
    }
    
    open func prepareView(){
        view.backgroundColor = .white
        self.title = "User Profile"
    }
    func prepareTopImage(){
        let image = UIImage(named: "doctor")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(250)
            make.width.equalTo(250)
        }
    }
    
    func prepareUsernameLabel(){
        view.addSubview(usernameLabel)
        usernameLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(350)
            make.centerX.equalToSuperview()
        }
    }
    
    func prepareEmailLabel(){
        self.view.addSubview(emailLabel)
        emailLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel).offset(50)
            make.centerX.equalToSuperview()
        }
    }
    
    func prepareLogoutButton(){
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.backgroundColor = blueColor
        logoutButton.layer.cornerRadius = 30
        logoutButton.layer.borderColor = UIColor(red: 237.0 / 255.0, green: 242.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0).cgColor
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints {make in
            make.leading.trailing.equalToSuperview().inset(60)
            self.bottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint.update(offset: -30)
            make.bottom.equalToSuperview().offset(50)
            make.height.equalTo(60)
        }
    }
    
    @objc private func didTapLogout(){
        AuthService.shared.signOut{[weak self] error in
            guard let self = self else{return}
            if let error = error{
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate{
                sceneDelegate.checkAuthentication()
            }
        }
    }
}
