//
//  PinBioSetupPageVC.swift
//  To-Do
//
//  Created by Sabbir Ahmed on 14/3/24.
//  Copyright © 2024 Aaryan Kothari. All rights reserved.
//

//
//  DashboardViewController.swift
//  To-Do
//
//  Created by Sabbir Ahmed on 14/3/24.
//  Copyright © 2024 Aaryan Kothari. All rights reserved.
//
 
import UIKit
 
class PinBioSetupPageVC: UIViewController {
 
  
    @IBOutlet weak var bioButton: UIButton!
     
    @IBOutlet weak var pinButton: UIButton!
    
 

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
 
        UserDefaults.standard.set(false, forKey: Constants.Key.onboarding)
    }

 

    @IBAction func bioButtonAction(_ sender: Any) {
        
        print("bioButtonAction")
        
         
    }
    
    @IBAction func pinButtonAction(_ sender: Any) {
 
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "PinsetupVC") as? PinsetupVC {
            //destinationVC.data = "Data you want to pass"
            navigationController?.pushViewController(destinationVC, animated: true)
            
            
        }
    }
 
 
}

 


