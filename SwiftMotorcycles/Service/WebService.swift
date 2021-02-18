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
    func getMotorcycle(id: String, completion: @escaping (WebResponse<Motorcycle>) -> Void)
    func deleteMotorcycle(id: String, completion: @escaping (WebResponse<Empty>) -> Void)
    func saveMotorcycle(motorcycle: Motorcycle, completion: @escaping (WebResponse<Empty>) -> Void)
}

class WebService : WebServiceProtocol {
    func getMotorcycles(completion: @escaping (WebResponse<[Motorcycle]>) -> Void) {
        var result = WebResponse<[Motorcycle]>(success: false, data: nil)
        
        AF
            .request(allMotorcyclesUrl)
            .validate()
            .responseDecodable(of: [Motorcycle].self) { (response) in
                guard let motorcycles = response.value else {
                    completion(result)
                    return
                }
                
                result.success = true
                result.data = motorcycles
                
                completion(result)
            }
    }
    
    func getMotorcycle(id: String, completion: @escaping (WebResponse<Motorcycle>) -> Void) {
        var result = WebResponse<Motorcycle>(success: false, data: nil)
        
        AF
            .request(oneMotorcycleUrl(id: id))
            .validate()
            .responseDecodable(of: Motorcycle.self) { (response) in
                guard let motorcycle = response.value else {
                    completion(result)
                    return
                }
                
                result.success = true
                result.data = motorcycle
                
                completion(result)
            }
    }
    
    func deleteMotorcycle(id: String, completion: @escaping (WebResponse<Empty>) -> Void) {
        var result = WebResponse<Empty>(success: false, data: Empty())
        
        AF
            .request(oneMotorcycleUrl(id: id), method: .delete)
            .validate()
            .responseJSON(completionHandler: { (response) in
                result.success = true
                result.data = Empty()
                
                completion(result)
            })
    }
    
    func saveMotorcycle(motorcycle: Motorcycle, completion: @escaping (WebResponse<Empty>) -> Void) {
        if motorcycle.objectId == "" {
            createNewMotorcycle(motorcycle: motorcycle, completion: completion)
        } else {
            updateMotorcycle(motorcycle: motorcycle, completion: completion)
        }
    }
    
    private func createNewMotorcycle(motorcycle: Motorcycle, completion: @escaping (WebResponse<Empty>) -> Void) {
        var result = WebResponse<Empty>(success: false, data: Empty())
                
        AF
            .request(allMotorcyclesUrl, method: .post, parameters: motorcycle, encoder: JSONParameterEncoder.default)
            .validate()
            .responseJSON(completionHandler: { (response) in
                result.success = true
                result.data = Empty()
                
                completion(result)
            })
    }
    
    private func updateMotorcycle(motorcycle: Motorcycle, completion: @escaping (WebResponse<Empty>) -> Void) {
        var result = WebResponse<Empty>(success: false, data: Empty())
        
        AF
            .request(oneMotorcycleUrl(id: motorcycle.objectId), method: .put, parameters: motorcycle, encoder: JSONParameterEncoder.default)
            .validate()
            .responseJSON(completionHandler: { (response) in
                result.success = true
                result.data = Empty()
                
                completion(result)
            })
    }
    
    let allMotorcyclesUrl = "\(Configuration.baseUrl)Motorcycles"
    func oneMotorcycleUrl(id: String) -> String { return "\(Configuration.baseUrl)Motorcycles/\(id)"}
}
