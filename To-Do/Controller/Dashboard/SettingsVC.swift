//
//  SettingsVC.swift
//  To-Do
//
//  Created by Sabbir Ahmed on 20/3/24.
 
//


import UIKit

class SettingsVC: UIViewController,UITextFieldDelegate {
    
    
 
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
        
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "TodoViewController") as? TodoViewController {
            navigationController?.pushViewController(destinationVC, animated: true)
        }
        
    }
    
    
    @IBAction func bioButtonAction(_ sender: Any) {
        print("Biometric setup")
        
        //        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "NoteListVC") as? NoteListVC {
        //            navigationController?.pushViewController(destinationVC, animated: true)
        //        }
        

        
        
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








