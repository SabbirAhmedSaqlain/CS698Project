//
//  LoginVC.swift
//  To-Do
//
//  Created by Sabbir Ahmed on 19/3/24.




import UIKit
import LocalAuthentication

class LoginVC: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var enterPin: UITextField!
    @IBOutlet weak var pinButton: UIButton!
    @IBOutlet weak var enterPinlebel: UILabel!
    @IBOutlet weak var bioLogin: UIButton!
    @IBOutlet weak var biologinlebel: UILabel!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        if UserDefaults.standard.bool(forKey: Constants.Key.face) {
            biologinlebel.isHidden = true
            bioLogin.isHidden = false
        }
        else{
            bioLogin.isHidden = true
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: Constants.Key.face) {
            biologinlebel.isHidden = true
            bioLogin.isHidden = false
        }
        else{
            bioLogin.isHidden = true
        }
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    @IBAction func pinButtonAction(_ sender: Any) {
        
        enterPin.resignFirstResponder()
        
        let inputPin = enterPin.text ?? ""
        let pin = UserDefaults.standard.string(forKey: Constants.Key.pin) ?? ""
        if pin == inputPin  {
            if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC {
                navigationController?.pushViewController(destinationVC, animated: true)
            }
            
        }else {
            showAlert(msg: "Wrong Pin Number!!!")
        }
        
    }
    
    
    @IBAction func bioButtonAction(_ sender: Any) {
        
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        
                        if let destinationVC = self?.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC {
                            self?.navigationController?.pushViewController(destinationVC, animated: true)
                        }
           
                    } else {
                        self?.showAlert(msg: "Authentication Failed!")
                    }
                }
            }
        } else {
            // no biometry
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







