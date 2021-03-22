//
//  WeekDayRepresentative.swift
//  Weather
//
//  Created by SMMC on 20/03/2021.
//

import UIKit

protocol WeekDayRepresentable {
    
    var day: String { get }
    var date: String { get }
    var temperature: String { get }
    var windSpeed: String { get }
    var image: UIImage? { get }

}
