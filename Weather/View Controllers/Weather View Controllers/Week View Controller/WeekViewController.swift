//
//  WeekViewController.swift
//  Weather
//
//  Created by SMMC on 24/02/2021.
//

import UIKit

final class WeekViewController: UIViewController {

    var viewModel: WeekViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            setupViewModel(with: viewModel)
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup View
        setupView()
    }
    
    // MARK: - Helper Methods
    
    private func setupView() {
        // Configure View
        view.backgroundColor = .red
    }
    
    private func setupViewModel(with viewModel: WeekViewModel) {
        print(viewModel)
    }
}
