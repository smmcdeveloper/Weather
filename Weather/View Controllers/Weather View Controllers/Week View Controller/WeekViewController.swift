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
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.isHidden = true
            tableView.dataSource = self
            tableView.separatorInset = .zero
            tableView.estimatedRowHeight = 44.0
            tableView.rowHeight = UITableView.automaticDimension
            tableView.showsVerticalScrollIndicator = false
        }
    }
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
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
        view.backgroundColor = .white
    }
    
    private func setupViewModel(with viewModel: WeekViewModel) {
        activityIndicatorView.stopAnimating()
        
        tableView.reloadData()
        tableView.isHidden = false
    }
}

extension WeekViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfDays ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekDayTableViewCell.reuseIdentifier, for: indexPath) as? WeekDayTableViewCell else {
            fatalError("Unable to Dequeue Week Day Table View Cell")
        }
        
        guard let viewModel = viewModel else {
            fatalError("No View Model Present")
        }
        
        cell.configure(with: viewModel.viewModel(for: indexPath.row) as! WeekDayRepresentable)
        
        return cell
    }
}
