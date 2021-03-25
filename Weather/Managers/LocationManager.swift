//
//  LocationManager.swift
//  Weather
//
//  Created by SMMC on 23/03/2021.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, LocationService {
    
    // MARK: -
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        
        locationManager.delegate = self
        
        return locationManager
    }()
    
    private var didFetchLocation: FetchLocationCompletion?
    
    func fetchLocation(completion: @escaping LocationService.FetchLocationCompletion) {
        didFetchLocation = completion
        
        locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    private func notAuthorizedToRequestLocation()
    {
        didFetchLocation?(nil,.notAuthorizedToRequestLocation)
        
        // make sure it can not be invoke more than 1 time
        didFetchLocation = nil
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
          case .authorizedAlways:
            // Fetch Location
            locationManager.requestLocation()
          case .authorizedWhenInUse:
            print("Authorization granted only when app is in use.")
          case .denied:
            notAuthorizedToRequestLocation()
          case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
          case .restricted:
            notAuthorizedToRequestLocation()
          @unknown default:
            notAuthorizedToRequestLocation()
          }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
       didFetchLocation?(Location(location: location), nil)
        
        // make sure it can not be invoke more than 1 time
        didFetchLocation = nil
    }
    

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to Fetch Location (\(error))")
    }
}

fileprivate extension Location {
    
    init(location: CLLocation) {
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
}
