//
//  Motorcycle.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2019-02-27.
//  Copyright © 2019 Jonas Frid. All rights reserved.
//

import Foundation

class Motorcycle: Decodable, Encodable {
    public let objectId: String
    public var brand: String
    public var model: String
    public var year: Int
    
    enum CodingKeys: String, CodingKey {
        case objectId
        case brand
        case model
        case year
    }
    
    init(objectId: String, brand: String, model: String, year: Int) {
        self.objectId = objectId
        self.brand = brand
        self.model = model
        self.year = year
    }
}
