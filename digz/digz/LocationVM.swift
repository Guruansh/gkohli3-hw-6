//
//  LocationVM.swift
//  FindMe
//
//  Created by Arthur Roolfs on 7/25/25.
//

import Foundation
import CoreLocation


class LocationVM: NSObject, ObservableObject {
    
    private let lm = CLLocationManager()
    
    @Published var location: CLLocation?
    @Published var authStatus: CLAuthorizationStatus = .notDetermined
    
    @Published var restrictedAlertPresenting = false
    @Published var deniedAlertPresenting = false
    @Published var enabled = false
    
    
    override init () {
        super.init()
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.distanceFilter = 10
        lm.delegate = self
    }
    
    func start() {
        lm.requestWhenInUseAuthorization()
        lm.startUpdatingLocation()
        enabled = true
    }
    
    func stop() {
        lm.stopUpdatingLocation()
        DispatchQueue.main.async {
            self.location = nil
        }
        enabled = false
    }
}

extension LocationVM: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        DispatchQueue.main.async {
            self.authStatus = status
        }
        
        switch status {
            
        case .authorizedAlways, .authorizedWhenInUse:
            break
        case .denied:
            DispatchQueue.main.async {
                self.deniedAlertPresenting = true
            }
        case .restricted:
            DispatchQueue.main.async {
                self.restrictedAlertPresenting = true
            }
        default: break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error getting location: " + error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last {
            DispatchQueue.main.async {
                self.location = loc
            }
        }
    }
}
