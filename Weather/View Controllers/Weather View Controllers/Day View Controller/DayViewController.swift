//
//  DayViewController.swift
//  Weather
//
//  Created by SMMC on 24/02/2021.
//

import UIKit

final class DayViewController: UIViewController {

    // MARK: - Properties
    
    var viewModel: DayViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            setupViewModel(with: viewModel)
        }
    }
    
    // MARK: -
    
    @IBOutlet var dataLabel: UILabel! {
        didSet {
            dataLabel.textColor = .baseTextColor
            dataLabel.font = UIFont.Weather.heavyLarge
        }
    }
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = .baseTintColor
        }
    }
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    // MARK: -
    
    @IBOutlet var regularLabels: [UILabel]! {
        didSet {
            for label in regularLabels {
                label.textColor = .black
                label.font = UIFont.Weather.lightRegular
            }
        }
    }
    
    @IBOutlet var smallLabels: [UILabel]! {
        didSet {
            for label in smallLabels {
                label.textColor = .black
                label.font = UIFont.Weather.lightSmall
            }
        }
    }
    
    @IBOutlet var weatherDataViews: [UIView]! {
        didSet {
            for view in weatherDataViews {
                view.isHidden = true
            }
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

         // Setup View
         setupView()
    }
    
    // MARK: Helper Methods
    private func setupView() {
        // Configure View
        view.backgroundColor = .lightBackgroundColor
    }

    private func setupViewModel(with viewModel: DayViewModel) {
        activityIndicatorView.stopAnimating()
        
        dataLabel.text = viewModel.date
        timeLabel.text = viewModel.time
        windSpeedLabel.text = viewModel.windSpeed
        temperatureLabel.text = viewModel.temperature
        descriptionLabel.text = viewModel.summary
        
        iconImageView.image = viewModel.image
        
        for view in weatherDataViews {
            view.isHidden = false
        }
    }
}
