//
//  RootViewModelTest.swift
//  WeatherTests
//
//  Created by SMMC on 30/03/2021.
//

import XCTest
@testable import Weather

class RootViewModelTest: XCTestCase {

    var viewModel: RootViewModel!
    
    override func setUp()  {
        super.setUp()
        
        viewModel = RootViewModel(locationService: MockLocationService())
    }

    override func tearDown()  {
        super.tearDown()
    }
    
    func testRefresh() {
        let expection = XCTestExpectation(description: "Fetch Weather Data")
        
        viewModel.didFetchWeatherData = { (result) in
            if case .success(let weatherData) = result {
                print(weatherData)
                expection.fulfill()
            }
        }
        
        viewModel.refresh()
        
        wait(for: [expection], timeout: 2.0)
    }
}
