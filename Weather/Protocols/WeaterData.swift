//
//  WeaterData.swift
//  Weather
//
//  Created by SMMC on 01/03/2021.
//

import Foundation

protocol WeatherData {
    
    var lat: Double { get }
    var lon: Double { get }
    
    var forecast: [ForecastWeatherConditions] { get }
}

protocol ForecastWeatherConditions {
    var icon: String { get }
    var description: String { get }
}
