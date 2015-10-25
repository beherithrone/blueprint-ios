//
//  Atlas_macOSTests.swift
//  Atlas-macOSTests
//
//  Copyright © 2015 Sky UK. All rights reserved.
//

import XCTest
@testable import Atlas_macOS

import Core
import RxSwift

class Atlas_macOSTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCoreMethodFromMacOSAppTests() {
        let core = CoreClass()
        XCTAssertEqual(core.coreStuff(), 1)
    }

    func testRxSwiftFromMacOSAppTests() {
        let expectation = self.expectationWithDescription("Expectation for RxSwift")

        let sequence = sequenceOf(1, 2)
        _ = sequence.subscribe({ event in
            if event == Event.Completed {
                expectation.fulfill()
            }
        })

        self.waitForExpectationsWithTimeout(10) { error in
            XCTAssertNil(error)
        }
    }
}
