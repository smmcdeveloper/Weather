//
//  UIViewController.swift
//  Weather
//
//  Created by SMMC on 26/02/2021.
//

import UIKit

extension UIViewController {
    
    // MARK: Static Properties
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
