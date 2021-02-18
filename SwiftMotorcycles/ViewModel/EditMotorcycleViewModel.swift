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
}

class EditMotorcycleViewModel: EditMotorcycleViewModelProtocol {
    private let webService: WebServiceProtocol?
    
    var propertyChanged: (String) -> Void = {propertyName in } // REMARK: Is this a good way to do it in Swift?

    init(webService: WebServiceProtocol?) {
        self.webService = webService
    }
}
