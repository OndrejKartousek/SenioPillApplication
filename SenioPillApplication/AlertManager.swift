//
//  AlertManager.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 18.12.2022.
//

import Foundation
import UIKit

class AlertManager{
    private static func showBasicAlert(on vc: UIViewController, with title: String, and message: String?){
       
        DispatchQueue.main.async{
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            vc.present(alert, animated: true)
        }
    }
}

extension AlertManager{
    
    public static func showInvalidEmailAlert(on vc: UIViewController){
        self.showBasicAlert(on: vc, with: "Invalid Email", and: "Please enter a valid e-mail")
    }
    
    public static func showInvalidPasswordAlert(on vc: UIViewController){
        self.showBasicAlert(on: vc, with: "Invalid password", and: "Please enter a valid password")
    }
    
    public static func showInvalidUsernameAlert(on vc: UIViewController){
        self.showBasicAlert(on: vc, with: "Invalid Email", and: "Please enter a valid username")
    }
    
    
}

extension AlertManager{
    
    public static func showRegistrationErrorAlert(on vc: UIViewController){
        self.showBasicAlert(on: vc, with: "Unknown Registration Error", and: nil)
    }
    public static func showRegistrationErrorAlert(on vc: UIViewController, with error: Error){
        self.showBasicAlert(on: vc, with: "Unknown Registration Error", and: "\(error.localizedDescription)")
    }
    //LOGIN ERR
    
}

extension AlertManager{
        
    public static func showSignInErrorAlert(on vc: UIViewController){
        self.showBasicAlert(on: vc, with: "Unknown Error Signing in ", and: nil)
    }
    public static func showSignInErrorAlert(on vc: UIViewController, with error: Error){
        self.showBasicAlert(on: vc, with: "Unknown Error Signing in", and: "\(error.localizedDescription)")
    }
        
}
//LOGOUT ERRORS
extension AlertManager{

    public static func showLogoutError(on vc: UIViewController, with error: Error){
        self.showBasicAlert(on: vc, with: "Unknown Error Signing in", and: "\(error.localizedDescription)")
    }
        
}

//FORGOT PASSWORD

extension AlertManager{
    
    public static func showPasswordResetSent(on vc: UIViewController){
        self.showBasicAlert(on: vc, with: "Password Reset Send", and: nil)
    }
        
    public static func showErrorSendingPasswordReset(on vc: UIViewController, with error: Error){
        self.showBasicAlert(on: vc, with: "Error Sending Password reset", and: "\(error.localizedDescription)")
    }
        
}

//USER ERRORS FETCHING

extension AlertManager{
    public static func showFetchingUserError(on vc: UIViewController, with error: Error){
        self.showBasicAlert(on: vc, with: "Error Fetching User", and: "\(error.localizedDescription)")
    }
    
    public static func showUnknownFetchingUserError(on vc: UIViewController){
        self.showBasicAlert(on: vc, with: "Unknown Error Fetching User", and: nil)
    }
}
