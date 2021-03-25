//
//  RootViewModel.swift
//  Weather
//
//  Created by SMMC on 28/02/2021.
//

import Foundation

class RootViewModel: NSObject {
    
    enum WeatherDataError: Error {
        case notAuthorizedToRequestLocation
        case failedToRequestLocation
        case noWeatherDataAvailable
    }
    
    // MARK: - Type Aliases
    
    typealias DidFetchWeaterDataCompletion = (WeatherData?, WeatherDataError?) -> Void
    
    // MARK: - Properties
    
    var didFetchWeatherData: DidFetchWeaterDataCompletion?
    
    private let locationService: LocationService
    
    // MARK: - Initialization
    
    init(locationService: LocationService) {
        self.locationService = locationService
        
        super.init()
        
        // Fetch Weather Data
        fetchWeatherData(for: Defaults.location)
        
        fetchLocation()
    }
    
    // MARK: - Helper Methods
    
    private func fetchLocation() {
       // Request Location
        locationService.fetchLocation { [weak self] (location, error) in
            if let error = error {
                print("Unable to Fetch Location (\(error)")
                
                self?.didFetchWeatherData?(nil, .notAuthorizedToRequestLocation)
            }
            if let location = location {
                self?.fetchWeatherData(for: location)
            } else {
                print ("Unable to Fetch Location")
                
                self?.didFetchWeatherData?(nil, .failedToRequestLocation)
            }
        }
    }
    
    private func fetchWeatherData(for location: Location) {
        // Initialize Weather Request
        //let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseUrl, location: location)
        
        let url2 = URL(string:"https://cocoacasts.com/clearsky/?api_key=tnperxfip8renk2hlzcccwetbnesby&lat=51.400592&long=4.76097") //"https://api.openweathermap.org/data/2.5/onecall?lat=33.441792&lon=-94.037689&appid=814058c9ea3ae6e1e9cd17c144759373")
        
        // Create Data Task weatherRequest.url
        URLSession.shared.dataTask(with:url2! ) { [weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }
            
            DispatchQueue.main.async {
               //print(">>>response: ",response)
               if let error = error {
                 print("Unable to Fetch Weather Data \(error)")
                
                self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
               } else if let data = data {
                    // Initialize JSON Decoder
                    let decoder = JSONDecoder()
                     
                    decoder.dateDecodingStrategy = .secondsSince1970
                
                    do {
                      // Decode JSON Response
                      let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                       self?.didFetchWeatherData?(weatherResponse, nil)
                    } catch{
                       print("Unable to Decode JSON Response \(error)")
                    
                       self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
                    }
               } else {
                 self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
               }
            }
        }.resume()
    }
}
