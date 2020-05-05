//
//  MapViewController.swift
//  compass
//
//  Created by Christopther Garcia on 4/29/20.
//  Copyright © 2020 Mac Cooper. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import YelpAPI
import CDYelpFusionKit

class MapViewController: UIViewController {
    
    class customPin: NSObject,MKAnnotation {
        var longitude: Double
        var latitude: Double
        var coordinate: CLLocationCoordinate2D
        var title: String?
        
        init(PinTitle:String, PinLatitude:Double, PinLongitude:Double) {
            self.title = PinTitle
            self.longitude = PinLongitude
            self.latitude = PinLatitude
            self.coordinate = .init(latitude: PinLatitude, longitude: PinLongitude)
        }
    }

    // variables
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    var longitude = 0.0
    var latitude = 0.0
    var offset = 0
    var fetchMore = false
    var resturantArray = [CDYelpBusiness]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        // Do any additional setup after loading the view.
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
            checkLocationAuthorization()
        } else {
            // Let them know they need to turn it on
        }
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            prepareRestuarants()
            break
        case .denied:
            // Display fix
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // show parental alert
            break
        case .authorizedAlways:
            break
        }
    }
    func prepareRestuarants() {
            let appSecret = "jA68XPwLGguQMoeEpcW2DMyw7tMB7MXXhmHcwqW_iRRIdMM3Nx_q-f7RjSMGaeDidFJfv7vNth1urlLXXsMPhNArpXmJNKz-yViahoE8MCmGV9sYTAheSzvqMNNmXnYx"
            
            // Search for 5 dinner restaurants
            let yelpAPIClient = CDYelpAPIClient(apiKey: appSecret)
            yelpAPIClient.cancelAllPendingAPIRequests()
            
            yelpAPIClient.searchBusinesses(byTerm: "Food",
                                           location: "San Francisco",
                                           latitude: nil,
                                           longitude: nil,
                                           radius: 1000,
                                           categories: nil,
                                           locale: .english_unitedStates,
                                           limit: 5,
                                           offset: offset,
                                           sortBy: .rating,
                                           priceTiers: nil,
                                           openNow: true,
                                           openAt: nil,
                                           attributes: nil) { (response) in
                                            if let response = response,
                                                let businesses = response.businesses,
                                                businesses.count > 0{
                                                self.offset = self.offset + 5
                                                for x in businesses {
                                                    self.resturantArray.append(x)
                                            
                                                    let pin = customPin(PinTitle: x.name!, PinLatitude: x.coordinates!.latitude!, PinLongitude: x.coordinates!.longitude!)
                                                    self.mapView.addAnnotation(pin)
                                                    
                                                    print(x.name!)
                                                    print(x)
                                                }
                                                DispatchQueue.main.async {
                                                }
                                            }
            }
            do{
                sleep(1)
            }
    }
    
    func loadMarkers() {
        
    }

}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // be back
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // be back
    }
}
