//
//  UserProfileViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 19.12.2022.
//

import UIKit

class UserProfileViewController: UIViewController {

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
        setupUI()
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
        let image = UIImage(named: "person.crop.square")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(0)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
    }
    
    private func setupUI(){
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
        self.view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            usernameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            usernameLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            emailLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emailLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 50),
            self.logoutButton.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 500),
            self.logoutButton.centerXAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 200),
            self.logoutButton.heightAnchor.constraint(equalToConstant: 44),
            self.logoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            ])
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
