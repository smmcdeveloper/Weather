//
//  WeatherRequest.swift
//  Weather
//
//  Created by SMMC on 28/02/2021.
//

import Foundation
import CoreLocation

struct WeatherRequest {
    
    let baseUrl: URL
    
    let location: CLLocation
    
    private var latitud: Double {
        return location.coordinate.latitude
    }
    
    private var longitud: Double {
        return location.coordinate.longitude
    }
    
    var url: URL {
        
        return baseUrl.appendingPathComponent("onecall?lat=\(latitud)&lon=\(longitud)&appid=814058c9ea3ae6e1e9cd17c144759373")
    }
}
