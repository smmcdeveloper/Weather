//
//  WeekViewModelTest.swift
//  WeatherTests
//
//  Created by SMMC on 20/03/2021.
//

import XCTest
@testable import Weather

class WeekViewModelTest: XCTestCase {

    var viewModel: WeekViewModel!
        
    override func setUp() {
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
        viewModel = WeekViewModel(weatherData: weatherResponse.forecast)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNumberOfDays() {
        XCTAssertEqual(viewModel.numberOfDays, 8)
    }
    
    func testViewModelForIndex() {
        let weekDayViewModel = viewModel.viewModel(for: 5)
        
        XCTAssertEqual(weekDayViewModel?.day, "Friday")
        XCTAssertEqual(weekDayViewModel?.date, "June 26")
    }
}
