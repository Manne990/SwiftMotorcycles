//
//  WebService.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2021-02-11.
//  Copyright © 2021 Jonas Frid. All rights reserved.
//

import Foundation
import Alamofire
import Combine

class CoreService {
    static func request<T: Decodable, E: Error>(
                url: String,
                method: HTTPMethod,
                parameters: Parameters?,
                decoder: JSONDecoder = JSONDecoder(),
                headers: HTTPHeaders? = nil
            ) -> Future<T, E> {
                return Future({ promise in
                    AF.request(
                        url,
                        method: method,
                        parameters: parameters,
                        headers: headers
                    ).responseDecodable(decoder: decoder, completionHandler: { (response: DataResponse<T, AFError>) in
                        switch response.result {
                            case .success(let value):
                                promise(.success(value))
                            case .failure(let error):
                                promise(.failure(
                                    NSError(domain: error.destinationURL?.absoluteString ?? "", code: error.responseCode ?? 0) as! E
                                    )
                            )
                        }
                    })
                })
            }
}

protocol WebServiceProtocol {
//    func getMotorcycles(completion: @escaping (WebResponse<[Motorcycle]>) -> Void)
    func getMotorcycles() -> Future<[Motorcycle], Error>
    func getMotorcycle(id: String, completion: @escaping (WebResponse<Motorcycle>) -> Void)
    func deleteMotorcycle(id: String, completion: @escaping (WebResponse<Empty>) -> Void)
    func saveMotorcycle(motorcycle: Motorcycle, completion: @escaping (WebResponse<Empty>) -> Void)
}

class WebService : CoreService, WebServiceProtocol {
    func getMotorcycles() -> Future<[Motorcycle], Error> {
//        var result = WebResponse<[Motorcycle]>(success: false, data: nil)
        
        return CoreService.request(
            url: allMotorcyclesUrl,
            method: HTTPMethod.get,
            parameters: nil
        )
        
//        AF
//            .request(allMotorcyclesUrl)
//            .validate()
//            .responseDecodable(of: [Motorcycle].self) { (response) in
//                guard let motorcycles = response.value else {
//                    completion(result)
//                    return
//                }
//
//                result.success = true
//                result.data = motorcycles
//
//                completion(result)
//            }
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
