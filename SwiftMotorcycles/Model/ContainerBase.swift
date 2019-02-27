//
//  ContainerBase.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2019-02-27.
//  Copyright © 2019 Jonas Frid. All rights reserved.
//

import Foundation

protocol ContainerProtocol {
    var success: Bool {get set}
}

class ContainerBase: ClassBase, ContainerProtocol {
    var success: Bool
    
    init(success: Bool) {
        self.success = success
    }
}
