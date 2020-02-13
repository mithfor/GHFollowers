//
//  GFError.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 08.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    
    case invalidUserName = "This username created an invalid request. Please try again"
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again"
    case unableToFavorites = "No favorites. Please try again"
    case alreadyInFavorites = "This user is already in your favorites!"
}
