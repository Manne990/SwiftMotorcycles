//
//  Motorcycle.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2019-02-27.
//  Copyright © 2019 Jonas Frid. All rights reserved.
//

import Foundation

struct Motorcycle: Decodable, Encodable {
    public let objectId: String
    public let brand: String
    public let model: String
    public let year: Int
    
    enum CodingKeys: String, CodingKey {
        case objectId
        case brand
        case model
        case year
    }
}
