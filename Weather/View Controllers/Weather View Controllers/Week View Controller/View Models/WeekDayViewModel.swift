//
//  WeekDayViewModel.swift
//  Weather
//
//  Created by SMMC on 20/03/2021.
//

import UIKit

struct WeekDayViewModel {
    
    // MARK: - Properties
    
    let weatherData: ForecastWeatherConditions
    
    // MARK: -
    
    private let dateFormatter = DateFormatter()
    
    // MARK: -
    
    var day: String {
        // Configure Date Formatter
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: weatherData.time)
    }
    
    var date: String {
        // Configure Date Formatter
        dateFormatter.dateFormat = "MMMM d"
        
        return dateFormatter.string(from: weatherData.time)
    }
    
    var temperature: String {
        let min = String(format: "%.1f °F",weatherData.temperatureMin)
        let max = String(format: "%.1f °F",weatherData.temperatureMax)
        
        return "\(min) - \(max)"
    }
    
    var windSpeed: String {
        return String(format: "%.f MPH", weatherData.windSpeed)
    }
    
    var image: UIImage? {
        return UIImage.imageForIcon(with: weatherData.icon)
    }
    
}

extension WeekDayViewModel: WeekDayRepresentable {
    
}
