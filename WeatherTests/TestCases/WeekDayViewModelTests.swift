//
//  WeekDayViewModelTests.swift
//  WeatherTests
//
//  Created by SMMC on 20/03/2021.
//

import XCTest
@testable import Weather

class WeekDayViewModelTests: XCTestCase {

    var viewModel: WeekDayViewModel!
    
    override func setUp()  {
        super.setUp()
        
        // Load Stub
        let data = loadStub(name: "weather", extension: "json")
        
        // Initialize JSON Decoder
        let decoder = JSONDecoder()
        
        // Configure JSON Decoder
        decoder.dateDecodingStrategy = .secondsSince1970
        
        // Initialize Dark Sky Response
        let weatherResponse = try! decoder.decode(WeatherResponse.self, from: data)
        
        // Initialize View Model
        viewModel = WeekDayViewModel(weatherData: weatherResponse.forecast[5])
    }

    override func tearDown()  {
        super.tearDown()
    }
}
