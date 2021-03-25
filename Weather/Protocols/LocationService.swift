//
//  LocationService.swift
//  Weather
//
//  Created by SMMC on 23/03/2021.
//

import Foundation

enum LocationServiceError {
    case notAuthorizedToRequestLocation
}

protocol LocationService {
    
    typealias FetchLocationCompletion = (Location?, LocationServiceError?) -> Void
    
    func fetchLocation(completion: @escaping FetchLocationCompletion) 
}
