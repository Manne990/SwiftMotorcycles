//
//  WebService.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2021-02-11.
//  Copyright © 2021 Jonas Frid. All rights reserved.
//

import Foundation
import Alamofire

protocol WebServiceProtocol {
    func getMotorcycles(completion: @escaping (WebResponse<[Motorcycle]>) -> Void)
}

class WebService : WebServiceProtocol {
    func getMotorcycles(completion: @escaping (WebResponse<[Motorcycle]>) -> Void) {
        var result = WebResponse<[Motorcycle]>(success: false, data: nil)
        
        //TODO: Add error handling
        
        AF
            .request("\(Configuration.baseUrl)Motorcycles")
            .validate()
            .responseDecodable(of: [Motorcycle].self) { (response) in
                guard let motorcycles = response.value else { return }
                result.success = true
                result.data = motorcycles
                completion(result)
            }
    }
}
