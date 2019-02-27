//
//  Motorcycle.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2019-02-27.
//  Copyright © 2019 Jonas Frid. All rights reserved.
//

import Foundation

class Motorcycle: ClassBase {
    var objectId: String
    var brand: String
    var model: String
    var year: Int
    
    init(objectId: String, brand: String, model: String, year: Int) {
        self.objectId = objectId
        self.brand = brand
        self.model = model
        self.year = year
    }
    
    convenience override init() {
        self.init(objectId: "", brand: "", model: "", year: 0)
    }
}
