//
//  BreedLis.swift
//  Randog
//
//  Created by Abdelrahman on 7/12/20.
//  Copyright © 2020 Abdelrahman. All rights reserved.
//

import Foundation

struct BreedList: Codable {
    let status: String
    var message: [String:[String]]
}
