//
//  WeaterData.swift
//  Weather
//
//  Created by SMMC on 01/03/2021.
//

import Foundation

protocol WeatherData {
 
    var latitud: Double { get }
    var longitud: Double { get }
    
    var current: CurrentWeatherConditions { get }
    var forecast: [ForecastWeatherConditions] { get }
}

protocol WeatherConditions {
    
    var time: Date { get }
    var icon: String { get }
    var windSpeed: Double { get }
    
}

protocol CurrentWeatherConditions: WeatherConditions {
    
    var summary: String { get }
    var temperature: Double { get }
    
}

protocol ForecastWeatherConditions: WeatherConditions {
    
    var temperatureMin: Double { get }
    var temperatureMax: Double { get }
    
}
