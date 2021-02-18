//
//  SwiftMotorcyclesTests.swift
//  SwiftMotorcyclesTests
//
//  Created by Jonas Frid on 2019-02-27.
//  Copyright © 2019 Jonas Frid. All rights reserved.
//

import XCTest
@testable import Pods_SwiftMotorcycles

class MotorcyclesViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadMotorcyclesSuccess() {
        // ARRANGE
        let subject = MotorcyclesViewModel(webService: WebServiceMock(shouldFail: false))
        
        // ACT
        subject.loadMotorcycles()
        
        // ASSERT
        XCTAssertEqual(1, subject.motorcycles!.count)
    }
    
    func testLoadMotorcyclesFail() {
        // ARRANGE
        let subject = MotorcyclesViewModel(webService: WebServiceMock(shouldFail: true))
        
        // ACT
        subject.loadMotorcycles()
        
        // ASSERT
        XCTAssertNil(subject.motorcycles)
    }
}
