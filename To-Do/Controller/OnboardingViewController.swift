//
//  OnboardingViewController.swift
//  To-Do
//
//  Created by Abraao Levi on 03/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private enum LocalConstants {
        static let cornerRadius: CGFloat = 10
    }
        
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var biometricButton: UIButton!

    @IBOutlet weak var pinTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func alreadyShown() -> Bool {
        return UserDefaults.standard.bool(forKey: Constants.Key.onboarding)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let pin = pinTextField.text ?? ""
        
        if pin.count == 0 {
            showAlert(msg: "Please Enter Your Pin Number")
        }else if pinTextField.text == "1234"{
            dismiss(animated: true)
        }
        else{
            showAlert(msg: "Wrong Pin Number")
        }
       
    }
    
    @IBAction func biometricButtonTapped(_ sender: Any) {
        markAsSeen()
        dismiss(animated: true)
    }
    
    
    
    private func markAsSeen() {
        UserDefaults.standard.set(true, forKey: Constants.Key.onboarding)
    }

    fileprivate func setupViews() {
        loginButton.layer.cornerRadius = LocalConstants.cornerRadius
        loginButton.clipsToBounds = true
        biometricButton.layer.cornerRadius = LocalConstants.cornerRadius
        biometricButton.clipsToBounds = true
    }
    
    func showAlert(msg: String) {
           // Create the alert controller
           let alert = UIAlertController(title: "Alert!!", message: msg, preferredStyle: .alert)

           // Add an action to the alert
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
               // Handle the OK action
               print("OK button tapped.")
           }))

           // Present the alert
           self.present(alert, animated: true, completion: nil)
       }

}
