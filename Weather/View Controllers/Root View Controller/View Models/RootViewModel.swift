//
//  RootViewModel.swift
//  Weather
//
//  Created by SMMC on 28/02/2021.
//

import UIKit

class RootViewModel: NSObject {
    
    enum WeatherDataError: Error {
        case notAuthorizedToRequestLocation
        case failedToRequestLocation
        case noWeatherDataAvailable
    }
    
    enum WeatherDataResult {
        case success(WeatherData)
        case failure(WeatherDataError)
    }
    
    // MARK: - Type Aliases
    
    typealias FetchWeaterDataCompletion = (WeatherDataResult) -> Void
    
    // MARK: - Properties
    
    var didFetchWeatherData: FetchWeaterDataCompletion?
    
    private let locationService: LocationService
    
    // MARK: - Initialization
    
    init(locationService: LocationService) {
        self.locationService = locationService
        
        super.init()
        
        // Fetch Weather Data
        fetchWeatherData(for: Defaults.location)
        
        setupNotificationHandling()
        
        fetchLocation()
    }
    
    // MARK: - Helper Methods
    
    private func fetchLocation() {
       // Request Location
        locationService.fetchLocation { [weak self] (result) in
            switch result {
                case .success(let location):
                    // Invoke Completion Handler
                    self?.fetchWeatherData(for: location)
                case .failure(let error):
                    print("Unable to Fetch Location(\(error))")
                    
                    let result:WeatherDataResult = .failure(.notAuthorizedToRequestLocation)
                    
                    // Invoke Completion Handler
                    self?.didFetchWeatherData?(result)
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
                
                let result:WeatherDataResult = .failure(.noWeatherDataAvailable)

                self?.didFetchWeatherData?(result)
               } else if let data = data {
                    // Initialize JSON Decoder
                    let decoder = JSONDecoder()
                     
                    decoder.dateDecodingStrategy = .secondsSince1970
                
                    do {
                        // Decode JSON Response
                        let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                        
                        let result:WeatherDataResult = .success(weatherResponse)
                        
                        UserDefaults.didFetchWeatherData = Date()
                        
                        // Invoke Completion Handler
                        self?.didFetchWeatherData?(result)
                    } catch{
                       print("Unable to Decode JSON Response \(error)")
                    
                        let result:WeatherDataResult = .failure(.noWeatherDataAvailable)

                        self?.didFetchWeatherData?(result)
                    }
               } else {
                 let result:WeatherDataResult = .failure(.noWeatherDataAvailable)

                 self?.didFetchWeatherData?(result)
               }
            }
        }.resume()
    }
    
    
    private func setupNotificationHandling() {
        
        // Application Will Enter Foreground
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: OperationQueue.main) { [weak self] (_) in
            guard let didFetchWeatherData = UserDefaults.didFetchWeatherData else {
                self?.refresh()
                return
            }
            if Date().timeIntervalSince(didFetchWeatherData) > Configuration.refreshThreshole {
                self?.refresh()
            }
         }
    }

    // MARK: -
    
    private func refresh() {
        fetchLocation()
    }
}

extension UserDefaults {
    
    private enum Keys {
        static let didFetchWeatherData = "didFetchWeatherData"
    }
    
    fileprivate class var didFetchWeatherData: Date? {
        get {
            return UserDefaults.standard.object(forKey: Keys.didFetchWeatherData) as? Date
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.didFetchWeatherData)
        }
    }
}
