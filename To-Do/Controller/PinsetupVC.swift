//
//  PinsetupVC.swift
//  To-Do
//
//  Created by Sabbir Ahmed on 14/3/24.
//  Copyright © 2024 Aaryan Kothari. All rights reserved.
//



import UIKit
 
class PinsetupVC: UIViewController,UITextFieldDelegate {
 
  
    @IBOutlet weak var enterPin: UITextField!
    @IBOutlet weak var reenterPin: UITextField!
    @IBOutlet weak var pinButton: UIButton!
 
  

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
 
       // UserDefaults.standard.set(false, forKey: Constants.Key.onboarding)
    }

 

    @IBAction func pinButtonAction(_ sender: Any) {
        
        enterPin.resignFirstResponder()
        reenterPin.resignFirstResponder()
        
        let Pin = enterPin.text ?? ""
        let rePin = reenterPin.text ?? ""
        
        print(Pin)
        print(rePin)
        
        if Pin != rePin  {
            showAlert(msg: "Pin Number number must be same")
        }else if Pin.count < 3{
            showAlert(msg: "Pin Number number must be greater than 3 digit")
        }
        else{
            UserDefaults.standard.set(Pin, forKey: Constants.Key.pin)
            
            if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "SetupSuccessfulVC") as? SetupSuccessfulVC {
                navigationController?.pushViewController(destinationVC, animated: true)
                
                
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

 



