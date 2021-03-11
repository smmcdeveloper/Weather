//
//  UIImage.swift
//  Weather
//
//  Created by SMMC on 11/03/2021.
//

import UIKit

extension UIImage {
    
    class func imageForIcon(with name: String) -> UIImage? {
        switch name {
            case "clear-day",
                 "clear-night",
                 "fog",
                 "rain",
                 "snow",
                 "sleet",
                 "wind":
                return UIImage(named: name)
                
            case "cloudy",
                 "partly-cloudy-day",
                 "partly-cloudy-night":
                return UIImage(named: "cloudy")
                
            default:
                return UIImage(named: "clear-day")
        }
    }
}
