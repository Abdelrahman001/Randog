//
//  Constants.swift
//  Randog
//
//  Created by Abdelrahman on 7/7/20.
//  Copyright © 2020 Abdelrahman. All rights reserved.
//

import Foundation

struct K {
    enum endpoint {
        case randomImageFromAllDogsBreeds
        case randomImageForBreed(String)
        case listOfAllBreeds
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogsBreeds:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listOfAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"

            }
        }
    }
}
