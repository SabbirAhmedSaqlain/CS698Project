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
 
        UserDefaults.standard.set(false, forKey: Constants.Key.onboarding)
    }

 

    @IBAction func startButtonAction(_ sender: Any) {
        
        print("Button")
        
        
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "PinBioSetupPageVC") as? PinBioSetupPageVC {
            //destinationVC.data = "Data you want to pass"
            navigationController?.pushViewController(destinationVC, animated: true)
            
            
        }
    }
    
 
 
 
}

 

