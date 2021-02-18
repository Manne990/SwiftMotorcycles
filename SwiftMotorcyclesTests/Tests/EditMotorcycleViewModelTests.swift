//
//  EditMotorcycleViewModelTests.swift
//  SwiftMotorcyclesTests
//
//  Created by Jonas Frid on 2021-02-18.
//  Copyright © 2021 Jonas Frid. All rights reserved.
//

import XCTest
@testable import Pods_SwiftMotorcycles

class EditMotorcycleViewModelTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithPayloadNew() {
        // ARRANGE
        let subject = EditMotorcycleViewModel(webService: WebServiceMock())
        
        // ACT
        subject.initWithPayload(payloadId: nil)
        
        // ASSERT
        XCTAssertEqual("", subject.motorcycle?.brand)
        XCTAssertEqual("", subject.motorcycle?.model)
        XCTAssertEqual(0, subject.motorcycle?.year)
    }
    
    func testInitWithPayloadEdit() {
        // ARRANGE
        let subject = EditMotorcycleViewModel(webService: WebServiceMock())
        
        // ACT
        subject.initWithPayload(payloadId: "1")
        
        // ASSERT
        XCTAssertEqual("1", subject.motorcycle?.objectId)
        XCTAssertEqual("Honda", subject.motorcycle?.brand)
        XCTAssertEqual("VFR800", subject.motorcycle?.model)
        XCTAssertEqual(1999, subject.motorcycle?.year)
    }
    
    func testSaveMotorcycleSuccess() {
        // ARRANGE
        let exp = expectation(description: "dummy")
        let subject = EditMotorcycleViewModel(webService: WebServiceMock())
        
        subject.initWithPayload(payloadId: "1")
        subject.motorcycle?.year = 2000
        
        // ACT
        subject.saveMotorcycle { (result) in
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
    
    func testSaveMotorcycleFail() {
        // ARRANGE
        let exp = expectation(description: "dummy")
        let subject = EditMotorcycleViewModel(webService: WebServiceMock(saveMotorcycleShouldFail: true))
        
        subject.initWithPayload(payloadId: "1")
        subject.motorcycle?.year = 2000
        
        // ACT
        subject.saveMotorcycle { (result) in
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
