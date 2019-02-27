//
//  Container.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2019-02-27.
//  Copyright © 2019 Jonas Frid. All rights reserved.
//

import Foundation

class MotorcyclesContainer: ContainerBase {
    var data: Array<Motorcycle>?
    
    init(success: Bool, data: Array<Motorcycle>?) {
        self.data = data
        
        super.init(success: success)
    }
}

class MotorcycleContainer: ContainerBase {
    var data: Motorcycle?
    
    init(success: Bool, data: Motorcycle?) {
        self.data = data
        
        super.init(success: success)
    }
}

class EmptyContainer: ContainerBase {
    
}
