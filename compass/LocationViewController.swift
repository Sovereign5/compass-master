//
//  LocationViewController.swift
//  compass
//
//  Created by Mac Cooper on 4/14/20.
//  Copyright © 2020 Mac Cooper. All rights reserved.
//
import UIKit
import CoreLocation
class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationView: LocationView!
    var locationService = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserLocationStatus()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            print("user is all authorized")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "userdidauthorizedlocation", sender: self)
            }
    }
    /////////////////////////////////////////////////

    @IBAction func allowButton(_ sender: Any) {
        print("hello")
        locationService.delegate = self
        locationService.requestWhenInUseAuthorization()
    }
    
    func checkUserLocationStatus() {
        print(CLLocationManager.authorizationStatus().rawValue)
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse, .denied:
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "userdidauthorizedlocation", sender: self)
            }
        default:
            break
        }
    }
    
    @IBAction func deButton(_ sender: Any) {
        DispatchQueue.main.async {
                       self.performSegue(withIdentifier: "userdidauthorizedlocation", sender: self)
                   }
    }
}
