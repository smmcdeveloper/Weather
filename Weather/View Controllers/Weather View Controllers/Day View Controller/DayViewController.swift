//
//  DayViewController.swift
//  Weather
//
//  Created by SMMC on 24/02/2021.
//

import UIKit

final class DayViewController: UIViewController {

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

}
