//
//  LoginViewController.swift
//  compass
//
//  Created by Mac Cooper on 4/7/20.
//  Copyright © 2020 Mac Cooper. All rights reserved.
//

import UIKit
import Parse
class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!

    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func checkUserLocationStatus() {
        print(CLLocationManager.authorizationStatus().rawValue)
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse, .denied:
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "loginwithauthlocation", sender: self)
            }
        default:
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
            
    }
    

    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
               let password = passwordField.text!
               
               PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
                   if user != nil{
                       self.checkUserLocationStatus()
                      // self.performSegue(withIdentifier: "loginSegue", sender: nil)
                   }else{
                       print("Error: \(error?.localizedDescription)")
                   }
               }
    }
    

    @IBAction func onSignup(_ sender: Any) {
         let user = PFUser()
               user.username = usernameField.text
               user.password = passwordField.text
               
               user.signUpInBackground { (success, error) in
                   if success{
                        self.checkUserLocationStatus()
                      // self.performSegue(withIdentifier: "loginSegue", sender: nil)
                   }else{
                       print("Error: \(error?.localizedDescription)")
                   }
               }
    }
}
