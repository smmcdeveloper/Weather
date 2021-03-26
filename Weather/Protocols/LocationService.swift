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

enum LocationServiceResult {
    case success(Location)
    case failure(LocationServiceError)
}

protocol LocationService {
    
    // MARK: - Type Aliasses
    
    typealias FetchLocationCompletion = (LocationServiceResult) -> Void
    
    // MARK: - Methods
    
    func fetchLocation(completion: @escaping FetchLocationCompletion) 
}
