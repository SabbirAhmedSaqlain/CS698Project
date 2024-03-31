//
//  SettingsVC.swift
//  To-Do
//
//  Created by Sabbir Ahmed on 20/3/24.
 
//


import UIKit
import LocalAuthentication

class SettingsVC: UIViewController,UITextFieldDelegate {
    
    
 
    @IBOutlet weak var pinButton: UIButton!
    @IBOutlet weak var bioLogin: UIButton!
    @IBOutlet weak var changePin: UIButton!
    
    
    let pinEnable = NSMutableAttributedString(string: "Pin Enable", attributes: [
        .font: UIFont.boldSystemFont(ofSize: 20),
        .backgroundColor: UIColor.green
    ])
    
    let pinDisable = NSMutableAttributedString(string: "Pin Disable", attributes: [
        .font: UIFont.boldSystemFont(ofSize: 20),
        .backgroundColor: UIColor.red
    ])
    
    let faceEnable = NSMutableAttributedString(string: "Face Enable", attributes: [
        .font: UIFont.boldSystemFont(ofSize: 20),
        .backgroundColor: UIColor.green
    ])
    
    let faceDisable = NSMutableAttributedString(string: "Face Disable", attributes: [
        .font: UIFont.boldSystemFont(ofSize: 20),
        .backgroundColor: UIColor.red
    ])
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pinButton.isHidden = true
        
        let pin = UserDefaults.standard.string(forKey: Constants.Key.pin) ?? ""
        if pin.count > 0 {
            pinButton.setAttributedTitle(pinEnable, for: .normal)
            pinButton.backgroundColor  = .green
        }
        else{
            pinButton.setAttributedTitle(pinDisable, for: .normal)
            pinButton.backgroundColor  = .red
        }
 
        
        if UserDefaults.standard.bool(forKey: Constants.Key.face) {
            bioLogin.setAttributedTitle(faceEnable, for: .normal)
            bioLogin.backgroundColor  = .green
        } else {
            bioLogin.setAttributedTitle(faceDisable, for: .normal)
            bioLogin.backgroundColor  = .red
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // UserDefaults.standard.set(false, forKey: Constants.Key.onboarding)
    }
    
    
    
    @IBAction func pinButtonAction(_ sender: Any) {
        
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "TodoViewController") as? TodoViewController {
            navigationController?.pushViewController(destinationVC, animated: true)
        }
        
    }
    
    @IBAction func changePINAction(_ sender: Any) {
    }
    
    @IBAction func bioButtonAction(_ sender: Any) {
        
        
        if UserDefaults.standard.bool(forKey: Constants.Key.face) {
            UserDefaults.standard.set(false, forKey: Constants.Key.face)
            bioLogin.setAttributedTitle(faceDisable, for: .normal)
            bioLogin.backgroundColor  = .red
        } else {

            let context = LAContext()
             var error: NSError?

             if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                 let reason = "Identify yourself!"

                 context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                     [weak self] success, authenticationError in

                     DispatchQueue.main.async {
                         if success {
                             
                             UserDefaults.standard.set(true, forKey: Constants.Key.face)
                             self?.bioLogin.setAttributedTitle(self?.faceEnable, for: .normal)
                             self?.bioLogin.backgroundColor  = .green
                             self?.showAlert(msg: "Bio Metric Login Enable Successful!")
                         } else {
                             self?.showAlert(msg: "Authentication Failed!")
                         }
                     }
                 }
             } else {
                 // no biometry
             }
            
            
        }
         
        
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








