//
//  WeatherRequest.swift
//  Weather
//
//  Created by SMMC on 28/02/2021.
//

import Foundation

struct WeatherRequest {
    
    let baseUrl: URL
    
    let location: Location
    
    private var latitud: Double {
        return location.latitude
    }
    
    private var longitud: Double {
        return location.longitude
    }
    
    var url: URL {
        
        return baseUrl.appendingPathComponent("onecall?lat=\(latitud)&lon=\(longitud)&appid=814058c9ea3ae6e1e9cd17c144759373")
    }
}
