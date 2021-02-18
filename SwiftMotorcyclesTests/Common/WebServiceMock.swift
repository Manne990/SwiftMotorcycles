//
//  WebServiceMock.swift
//  SwiftMotorcyclesTests
//
//  Created by Jonas Frid on 2021-02-18.
//  Copyright © 2021 Jonas Frid. All rights reserved.
//

import Foundation

class WebServiceMock : WebServiceProtocol {
    
    let shouldFail: Bool
    
    init(shouldFail: Bool) {
        self.shouldFail = shouldFail
    }
    
    func getMotorcycles(completion: @escaping (WebResponse<[Motorcycle]>) -> Void) {
        var data = [Motorcycle]()
        
        if self.shouldFail == false {
            data.append(Motorcycle(objectId: "1", brand: "Honda", model: "VFR800", year: 1999))
        }
        
        let result = WebResponse<[Motorcycle]>(success: !self.shouldFail, data: data)
        
        completion(result)
    }
}
