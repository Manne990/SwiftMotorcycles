//
//  ClassBase.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2019-02-27.
//  Copyright © 2019 Jonas Frid. All rights reserved.
//

import Foundation

class ClassBase {
    func toString() -> String {
        var params = [String]()
        
        let mirror = Mirror(reflecting: self)
        
        for (_, attr) in mirror.children.enumerated() {
            if let property_name = attr.label {
                params.append("\(property_name)=\(attr.value)")
            }
        }
        return "\(type(of: self)) (\(params))"
    }
}
