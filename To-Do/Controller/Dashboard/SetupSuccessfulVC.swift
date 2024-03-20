//
//  SetupSuccessfulVC.swift
//  To-Do
//
//  Created by Sabbir Ahmed on 19/3/24.




import UIKit
 
class SetupSuccessfulVC: UIViewController {
 

    @IBOutlet weak var backButton: UIButton!
 
  

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

 
 

    @IBAction func pinButtonAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
 
 
}

 






