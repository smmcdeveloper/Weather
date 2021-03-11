//
//  RootViewModel.swift
//  Weather
//
//  Created by SMMC on 28/02/2021.
//

import Foundation

class RootViewModel {
    
    enum WeatherDataError: Error {
        case noWeatherDataAvailable
    }
    
    // MARK: - Type Aliases
    
    typealias DidFetchWeaterDataCompletion = (WeatherData?, WeatherDataError?) -> Void
    
    // MARK: - Properties
    
    var didFetchWeatherData: DidFetchWeaterDataCompletion?
    
    // MARK: - Initialization
    
    init() {
        fetchWeatherData()
    }
    
    // MARK: -
    
    private func fetchWeatherData() {
    
        // Create URL
        let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseUrl, location: Defaults.location)
        
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
