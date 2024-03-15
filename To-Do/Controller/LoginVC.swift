//
//  LoginVC.swift
//  To-Do
//
//  Created by Sabbir Ahmed on 14/3/24.
//  Copyright © 2024 Aaryan Kothari. All rights reserved.
//
 

import UIKit
 
class LoginVC: UIViewController,UITextFieldDelegate {
 
  
    @IBOutlet weak var enterPin: UITextField!
    @IBOutlet weak var pinButton: UIButton!
    @IBOutlet weak var bioLogin: UIButton!
    

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
 
       // UserDefaults.standard.set(false, forKey: Constants.Key.onboarding)
    }

 

    @IBAction func pinButtonAction(_ sender: Any) {
        
        enterPin.resignFirstResponder()
 
        let inputPin = enterPin.text ?? ""
        let pin = UserDefaults.standard.string(forKey: Constants.Key.pin) ?? ""
        
        
        
        if pin == inputPin  {
            ////Successful login
            ///
            if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "NoteListVC") as? NoteListVC {
                navigationController?.pushViewController(destinationVC, animated: true)
            }
            
        }else {
            showAlert(msg: "Wrong Pin Number!!!")
        }
        
    }
    
    
    @IBAction func bioButtonAction(_ sender: Any) {
        print("Biometric setup")
        
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "NoteListVC") as? NoteListVC {
            navigationController?.pushViewController(destinationVC, animated: true)
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

 




