//
//  MotorcyclesViewModel.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2021-02-11.
//  Copyright © 2021 Jonas Frid. All rights reserved.
//

import Foundation
import Combine

protocol MotorcyclesViewModelProtocol {
    var propertyChanged: (String) -> Void {get set}
    var motorcycles: [Motorcycle]? {get}
    
    func loadMotorcycles()
    func deleteMotorcycle(motorcycle: Motorcycle, completion: @escaping (Bool) -> Void)
}

class MotorcyclesViewModel : MotorcyclesViewModelProtocol {
    private let webService: WebServiceProtocol?
    
    private var subscriptions: Set<AnyCancellable> = []
    
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
        
        webService?.getMotorcycles()
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    // error
                }
                else {
                    // success
                }
            }, receiveValue: { items in
                self.motorcycles = items.sorted {
                    $0.brand < $1.brand // TODO: Sort on more properties
                }
            })
            .store(in: &subscriptions)
        
//        webService?.getMotorcycles{ (result) in
//            guard result.success else {
//                self.motorcycles = nil
//                return
//            }
//
//            if let motorcycles = result.data {
//                self.motorcycles = motorcycles.sorted {
//                    $0.brand < $1.brand // TODO: Sort on more properties
//                }
//            }
//        }
    }
    
    func deleteMotorcycle(motorcycle: Motorcycle, completion: @escaping (Bool) -> Void) {
        webService?.deleteMotorcycle(id: motorcycle.objectId, completion: { (result) in
            self.loadMotorcycles()
            completion(result.success)
        })
    }
}
