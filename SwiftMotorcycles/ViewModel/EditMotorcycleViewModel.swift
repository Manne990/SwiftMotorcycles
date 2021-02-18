//
//  EditMotorcycleViewModel.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2021-02-18.
//  Copyright © 2021 Jonas Frid. All rights reserved.
//

import Foundation

protocol EditMotorcycleViewModelProtocol {
    var propertyChanged: (String) -> Void {get set}
    var motorcycle: Motorcycle? {get set}
    
    func initWithPayload(payloadId: String?)
    func saveMotorcycle(completion: @escaping (Bool) -> Void)
}

class EditMotorcycleViewModel: EditMotorcycleViewModelProtocol {
    private let webService: WebServiceProtocol?
    
    var propertyChanged: (String) -> Void = {propertyName in } // REMARK: Is this a good way to do it in Swift?

    private var _motorcycle: Motorcycle? // REMARK: Is this a good way to do it in Swift?
    var motorcycle: Motorcycle? {
        get { return _motorcycle }
        set {
            _motorcycle = newValue
            propertyChanged("motorcycle")
        }
    }
    
    init(webService: WebServiceProtocol?) {
        self.webService = webService
    }
    
    func initWithPayload(payloadId: String?) {
        guard let id = payloadId else {
            motorcycle = Motorcycle(objectId: "", brand: "", model: "", year: 0)
            return
        }
        
        webService?.getMotorcycle(id: id, completion: { (result) in
            guard result.success else {
                self.motorcycle = nil
                return
            }
            
            self.motorcycle = result.data
        })
    }
    
    func saveMotorcycle(completion: @escaping (Bool) -> Void) {
        //TODO: Add validation
        
        guard let mc = motorcycle else {
            return
        }
        
        webService?.saveMotorcycle(motorcycle: mc, completion: { (result) in
            completion(result.success)
        })
    }
}
