//
//  MotorcyclesViewModel.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2021-02-11.
//  Copyright © 2021 Jonas Frid. All rights reserved.
//

import Foundation

protocol MotorcyclesViewModelProtocol {
    var propertyChanged: (String) -> Void {get set}
    var motorcycles: [Motorcycle]? {get}
    
    func loadMotorcycles()
    func deleteMotorcycle(motorcycle: Motorcycle)
}

class MotorcyclesViewModel : MotorcyclesViewModelProtocol {
    private let webService: WebServiceProtocol?
    
    var propertyChanged: (String) -> Void = {propertyName in } // REMARK: Is this a good way to do it in Swift?
    
    private var _motorcycles: [Motorcycle]? // REMARK: Is this a good way to do it in Swift?
    var motorcycles: [Motorcycle]? {
        get { return _motorcycles }
        set {
           _motorcycles = newValue
            propertyChanged("motorcycles")
        }
    }
    
    init(webService: WebServiceProtocol?) {
        self.webService = webService
    }
    
    func loadMotorcycles() {
        webService?.getMotorcycles{ (result) in
            guard result.success else {
                self.motorcycles = nil
                return
            }
            
            if let motorcycles = result.data {
                self.motorcycles = motorcycles.sorted {
                    $0.brand < $1.brand // TODO: Sort on more properties
                }
            }
        }
    }
    
    func deleteMotorcycle(motorcycle: Motorcycle) {
        webService?.deleteMotorcycle(id: motorcycle.objectId, completion: { (result) in
            guard result.success else {
                return
            }
            
            self.loadMotorcycles()
        })
    }
}
