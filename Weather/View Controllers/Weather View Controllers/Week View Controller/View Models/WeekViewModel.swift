//
//  WeekViewModel.swift
//  Weather
//
//  Created by SMMC on 09/03/2021.
//

import Foundation

struct WeekViewModel {
    
    // MARK: - Properties
    
    let weatherData: [ForecastWeatherConditions]
    
    
    // MARK: -
    
    var numberOfDays: Int {
        return weatherData.count
    }
    
    // MARK: - Methods
    
    func viewModel(for index: Int) -> WeekDayViewModel? {
        guard index < weatherData.count else {
            return nil
        }
        
        return WeekDayViewModel(weatherData: weatherData[index])
    }
}
