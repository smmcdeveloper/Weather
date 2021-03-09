//
//  DayViewController.swift
//  Weather
//
//  Created by SMMC on 24/02/2021.
//

import UIKit

final class DayViewController: UIViewController {

    var viewModel: DayViewModel? {
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
    
    // MARK: Helper Methods
    private func setupView() {
        // Configure View
        view.backgroundColor = .green
    }

    private func setupViewModel(with viewModel: DayViewModel) {
        print(viewModel)
    }
}
