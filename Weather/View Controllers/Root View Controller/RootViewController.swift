//
//  RootViewController.swift
//  Weather
//
//  Created by SMMC on 22/02/2021.
//

import UIKit

final class RootViewController: UIViewController {

    private enum AlertType {
        case notAuthorizedToRequestLocation
        case noWeatherDataAvailable
    }
    
    // MARK: - Properties
    
    var viewModel: RootViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            setupViewModel(with: viewModel)
        }
    }
    
    private let dayViewController: DayViewController = {
        guard let dayViewController = UIStoryboard.main.instantiateViewController(withIdentifier: DayViewController.storyboardIdentifier) as? DayViewController else {
             fatalError("Unable to Instantiate Day View Controller")
            }
        
        // Configure Day View Controller
        dayViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        return dayViewController
    }()
    
    private let weekViewController: WeekViewController = {
        guard let weekViewController = UIStoryboard.main.instantiateViewController(withIdentifier: WeekViewController.storyboardIdentifier) as? WeekViewController else {
             fatalError("Unable to Instantiate Day View Controller")
            }
        
        // Configure Day View Controller
        weekViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        return weekViewController
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Child View Controllers
        setupChildViewControllers()
    }
    
    // MARK: - Helper Methods
    
    private func setupChildViewControllers() {
        // Add Child View Controller
        addChild(dayViewController)
        addChild(weekViewController)
        
        // Add Child View as Subview
        view.addSubview(dayViewController.view)
        view.addSubview(weekViewController.view)
        
        // Configure Day View
        dayViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dayViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        dayViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        // Configure week View
        weekViewController.view.topAnchor.constraint(equalTo:dayViewController.view.bottomAnchor).isActive = true
        weekViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        weekViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        weekViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Notify Child view Controller
        dayViewController.didMove(toParent: self)
        weekViewController.didMove(toParent: self)
    }
    
    private func setupViewModel(with viewModel: RootViewModel) {
       // Configure View Model
       viewModel.didFetchWeatherData = { [weak self] (weatherData, error) in
         if let error = error {
            DispatchQueue.main.async {
                var alertType: AlertType
                
                switch error {
                    case .notAuthorizedToRequestLocation:
                        alertType = .notAuthorizedToRequestLocation
                    case .noWeatherDataAvailable:
                        alertType = .noWeatherDataAvailable
                }
                
              // Notify User
              self?.presentAlert(of: .noWeatherDataAvailable)
            }
         } else if let weatherData = weatherData as? WeatherResponse {
            //print("weatherData ",weatherData)
            let dayViewModel = DayViewModel(weatherData: weatherData.current)
            self?.dayViewController.viewModel = dayViewModel
            
            let weekViewModel = WeekViewModel(weatherData: weatherData.forecast)
            
            self?.weekViewController.viewModel = weekViewModel
            
         } else {
            DispatchQueue.main.async {
             self?.presentAlert(of: .noWeatherDataAvailable)
            }
         }
       }
     }
    
    private func presentAlert(of alertType: AlertType) {
        let title: String
        let message: String
        
        switch alertType {
         case .noWeatherDataAvailable:
                title = "Unable to Fetch Weather Data"
                message = "The application is unable to fetch"
         case .notAuthorizedToRequestLocation:
                title = "Unable to Fetch Weather Data for Your Location"
                message = "Weather Report is not authorized to access your current location."
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: title, style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true,completion: nil)
    }

}


