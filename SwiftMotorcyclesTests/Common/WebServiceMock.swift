//
//  WebServiceMock.swift
//  SwiftMotorcyclesTests
//
//  Created by Jonas Frid on 2021-02-18.
//  Copyright © 2021 Jonas Frid. All rights reserved.
//

import Foundation

class WebServiceMock : WebServiceProtocol {
    
    let getMotorcyclesShouldFail: Bool
    let getMotorcycleShouldFail: Bool
    let deleteMotorcycleShouldFail: Bool
    let saveMotorcycleShouldFail: Bool
    
    init(getMotorcyclesShouldFail: Bool = false, getMotorcycleShouldFail: Bool = false, deleteMotorcycleShouldFail: Bool = false, saveMotorcycleShouldFail: Bool = false) {
        self.getMotorcyclesShouldFail = getMotorcyclesShouldFail
        self.getMotorcycleShouldFail = getMotorcycleShouldFail
        self.deleteMotorcycleShouldFail = deleteMotorcycleShouldFail
        self.saveMotorcycleShouldFail = saveMotorcycleShouldFail
    }
    
    func getMotorcycles(completion: @escaping (WebResponse<[Motorcycle]>) -> Void) {
        var data = [Motorcycle]()
        
        if self.getMotorcyclesShouldFail == false {
            data.append(Motorcycle(objectId: "1", brand: "Honda", model: "VFR800", year: 1999))
        }
        
        let result = WebResponse<[Motorcycle]>(success: !self.getMotorcyclesShouldFail, data: data)
        
        completion(result)
    }
    
    func getMotorcycle(id: String, completion: @escaping (WebResponse<Motorcycle>) -> Void) {
        let data = self.getMotorcycleShouldFail ? nil : Motorcycle(objectId: id, brand: "Honda", model: "VFR800", year: 1999)
        
        let result = WebResponse<Motorcycle>(success: !self.getMotorcycleShouldFail, data: data)
        
        completion(result)
    }
    
    func deleteMotorcycle(id: String, completion: @escaping (WebResponse<Empty>) -> Void) {
        completion(WebResponse<Empty>(success: !self.deleteMotorcycleShouldFail, data: Empty()))
    }
    
    func saveMotorcycle(motorcycle: Motorcycle, completion: @escaping (WebResponse<Empty>) -> Void) {
        completion(WebResponse<Empty>(success: !self.saveMotorcycleShouldFail, data: Empty()))
    }
}
