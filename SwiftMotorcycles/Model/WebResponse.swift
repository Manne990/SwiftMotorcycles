//
//  ContainerBase.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2019-02-27.
//  Copyright © 2019 Jonas Frid. All rights reserved.
//

import Foundation

struct WebResponse<T> {
    var success: Bool
    var data: T?
}
