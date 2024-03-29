//
//  LoginViewController.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 17.12.2022.
//

import UIKit

class LoginController: UIViewController {
    
    private let headerView = AuthHeaderView(title: "Sign In", subTitle: "Sign into your account")
    
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)

    private let signInButton = CustomButton(title: "Sign in", hasBackground: true, fontSize : .big)
    private let newUserButton = CustomButton(title: "New User? Create account. ", fontSize: .med)
    private let forgotPasswordButton = CustomButton(title: "Forgot Password?", fontSize: .small)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
        self.forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI(){
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(headerView)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signInButton)
        self.view.addSubview(newUserButton)
        self.view.addSubview(forgotPasswordButton)

        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        newUserButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 222),
            
            self.emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 102),
            self.emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            
            self.passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 12),
            self.passwordField.centerXAnchor.constraint(equalTo: emailField.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 12),
            self.signInButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.signInButton.heightAnchor.constraint(equalToConstant: 55),
            self.signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.newUserButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 12),
            self.newUserButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.newUserButton.heightAnchor.constraint(equalToConstant: 44),
            self.newUserButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.forgotPasswordButton.topAnchor.constraint(equalTo: newUserButton.bottomAnchor, constant: 6),
            self.forgotPasswordButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.forgotPasswordButton.heightAnchor.constraint(equalToConstant: 44),
            self.forgotPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
            
        ])
        
    }
    
    @objc private func didTapSignIn(){
        
        let loginRequest = LoginUserRequest(
            email: self.emailField.text ?? "",
            password: self.passwordField.text ?? ""
            
        )
        //email
        if !Validator.isValidEmail(for: loginRequest.email){
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        //password
        if !Validator.isPasswordValid(for: loginRequest.password){
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.signIn(with: loginRequest) { [weak self]
            error in
            guard let self = self else {return}
            if let error = error{
                AlertManager.showSignInErrorAlert(on: self, with: error)

                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate{
                sceneDelegate.checkAuthentication()
            }else{
                AlertManager.showSignInErrorAlert(on: self)
            }
        }

    }
    
    @objc private func didTapNewUser(){
        let vc = RegisterController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapForgotPassword(){
        let vc = ForgotPasswordController()
        self.navigationController?.pushViewController(vc, animated: true)
    }


    @objc open func performContinue(){
        let tabBarController = BaseTabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true, completion: nil)
    }
}
