//
//  MockLocationService.swift
//  WeatherTests
//
//  Created by SMMC on 30/03/2021.
//

import Foundation
@testable import Weather

class MockLocationService: LocationService {
    
    var location: Location = Location(latitude: 0.0, longitude: 0.0)
    var delay: TimeInterval = 0.0
    
    func fetchLocation(completion: @escaping  LocationService.FetchLocationCompletion) {
        let result: LocationServiceResult = .success(location)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            completion(result)
        }
    }
    
}
