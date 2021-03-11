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
    
    @IBOutlet var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
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
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

         // Setup View
         setupView()
    }
    
    // MARK: Helper Methods
    private func setupView() {
        // Configure View
        view.backgroundColor = .green
    }

    private func setupViewModel(with viewModel: DayViewModel) {
        print(viewModel)
    }
}
