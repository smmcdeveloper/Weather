//
//  DayViewModelTests.swift
//  WeatherTests
//
//  Created by SMMC on 13/03/2021.
//

import XCTest
@testable import Weather

class DayViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: DayViewModel!

    // MARK: - Set Up & Tear Down
    
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
        viewModel = DayViewModel(weatherData: weatherResponse.current)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests for Date
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "Mon, June 22 2020")
    }

    // MARK: - Tests for Time
    
    func testTime() {
        XCTAssertEqual(viewModel.time, "03:53 PM")
    }

    // MARK: - Tests for Summary
    
    func testSummary() {
        XCTAssertEqual(viewModel.summary, "Overcast")
    }
    
    // MARK: - Tests for Temperature
    
    func testTemperature() {
        XCTAssertEqual(viewModel.temperature, "68.7 °F")
    }
    
    // MARK: - Tests for Wind Speed
    
    func testWindSpeed() {
        XCTAssertEqual(viewModel.windSpeed, "6 MPH")
    }
    
    // MARK: - Tests for Image
    
    func testImage() {
        let viewModelImage = viewModel.image
        let imageDataViewModel = viewModelImage!.pngData()!
        let imageDataReference = UIImage(named: "cloudy")!.pngData()!
        
        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImage!.size.width, 45.0)
        XCTAssertEqual(viewModelImage!.size.height, 33.0)
        XCTAssertEqual(imageDataViewModel, imageDataReference)
    }
    
}
