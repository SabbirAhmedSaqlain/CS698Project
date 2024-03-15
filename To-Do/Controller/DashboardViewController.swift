//
//  DashboardViewController.swift
//  To-Do
//
//  Created by Sabbir Ahmed on 14/3/24.
//  Copyright © 2024 Aaryan Kothari. All rights reserved.
//

import UIKit


class DashboardViewController: UIViewController {
    
    
    @IBOutlet weak var startButton: UIButton!
    
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //UserDefaults.standard.set(false, forKey: Constants.Key.onboarding)
    }
    
    
    
    @IBAction func startButtonAction(_ sender: Any) {
        
        let pin = UserDefaults.standard.string(forKey: Constants.Key.pin) ?? ""
        if pin.count > 0 {
            if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
                navigationController?.pushViewController(destinationVC, animated: true)
            }
        }
        else{
            if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "PinBioSetupPageVC") as? PinBioSetupPageVC {
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



