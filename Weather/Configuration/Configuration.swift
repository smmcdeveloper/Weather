//
//  Configuration.swift
//  Weather
//
//  Created by SMMC on 28/02/2021.
//

import Foundation
import CoreLocation

enum Defaults {
    static let location = CLLocation(latitude: 37.335114, longitude: -122.008928)
}

enum WeatherService {
    /*
     https://api.openweathermap.org/data/2.5/onecall?lat=33.441792&lon=-94.037689&appid=814058c9ea3ae6e1e9cd17c144759373
     */
    private static let apiKey = "814058c9ea3ae6e1e9cd17c144759373"
    private static let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/")
    
    static var authenticatedBaseUrl: URL {
        return (baseUrl?.appendingPathComponent(apiKey))!
    }
}
