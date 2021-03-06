//
//  WeatherResponse.swift
//  Weather
//
//  Created by SMMC on 01/03/2021.
//

import Foundation

 struct WeatherResponse: Codable {

     struct Daily: Codable {
       let dt: Date
       let temp: Double
       let wind_speed: Double
       let weather: [Conditions]
        
       struct Conditions: Codable {
         let icon: String
         let description: String
      }
    }
    
     let lat: Double
     let lon: Double
    
     let current: Daily

}

extension WeatherResponse: WeatherData {
    var forecast: [ForecastWeatherConditions] {
        return current.weather
    }
}

extension WeatherResponse.Daily.Conditions: ForecastWeatherConditions {
    
}
