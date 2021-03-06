//
//  EditMotorcycleViewModelTests.swift
//  SwiftMotorcyclesTests
//
//  Created by Jonas Frid on 2021-02-18.
//  Copyright © 2021 Jonas Frid. All rights reserved.
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
        let subject = MotorcyclesViewModel(webService: WebServiceMock())
        
        // ACT
        subject.loadMotorcycles()
        
        // ASSERT
        XCTAssertEqual(1, subject.motorcycles!.count)
    }
    
    func testLoadMotorcyclesFail() {
        // ARRANGE
        let subject = MotorcyclesViewModel(webService: WebServiceMock(getMotorcyclesShouldFail: true))
        
        // ACT
        subject.loadMotorcycles()
        
        // ASSERT
        XCTAssertNil(subject.motorcycles)
    }
    
    func testDeleteMotorcycleSuccess() {
        // ARRANGE
        let exp = expectation(description: "dummy")
        let subject = MotorcyclesViewModel(webService: WebServiceMock())
        
        subject.loadMotorcycles()
        
        // ACT
        subject.deleteMotorcycle(motorcycle: subject.motorcycles![0]) { (result) in
            // ASSERT
            XCTAssertTrue(result)
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
              XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testDeleteMotorcycleFail() {
        // ARRANGE
        let exp = expectation(description: "dummy")
        let subject = MotorcyclesViewModel(webService: WebServiceMock(deleteMotorcycleShouldFail: true))
        
        subject.loadMotorcycles()
        
        // ACT
        subject.deleteMotorcycle(motorcycle: subject.motorcycles![0]) { (result) in
            // ASSERT
            XCTAssertFalse(result)
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
              XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
}
