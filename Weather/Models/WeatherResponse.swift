//
//  WeatherResponse.swift
//  Weather
//
//  Created by SMMC on 01/03/2021.
//

 
 import Foundation

  struct WeatherResponse: Codable {
    
    struct Conditions: Codable {
          let time: Date
          let icon: String
          let summary: String
          let windSpeed: Double
          let temperature: Double
     }
     
    struct Daily: Codable {
          let data: [Conditions]
         
          struct Conditions: Codable {
              let time: Date
              let icon: String
              let windSpeed: Double
              let temperatureMin: Double
              let temperatureMax: Double
         }
     }
     
      let latitude: Double
      let longitude: Double
     
      let daily: Daily
      let currently: Conditions
 }

extension WeatherResponse: WeatherData {
    var latitud: Double {
        return latitude
    }
    
    var longitud: Double {
        return longitude
    }
    
    
    var current: CurrentWeatherConditions {
        return currently
    }
    
    var forecast: [ForecastWeatherConditions] {
        return daily.data
    }
    
}

extension WeatherResponse.Conditions: CurrentWeatherConditions {
    
}

extension WeatherResponse.Daily.Conditions: ForecastWeatherConditions {
    
}

