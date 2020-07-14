//
//  MainThreadTests.swift
//  Practical Dependency InversionTests
//
//  Created by 游宗諭 on 2020/7/14.
//  Copyright © 2020 Hanyu. All rights reserved.
//

import XCTest
@testable import Practical_Dependency_Inversion

class MainThreadDecoratorTests: XCTestCase {
    
    
    func testCanCheckNotOnMainQueue() throws {
        let testQueue = DispatchQueue(label: #function)
        let await = XCTestExpectation(description: #function)
        var result:Bool?
        testQueue.async {
            checkQueue(queue: .main, result: &result)
            await.fulfill()
        }
        wait(for: [await], timeout: 1)
        let returned = try XCTUnwrap(result)
        XCTAssertFalse(returned)
    }
    func testCanCheckIsOnMainQueue() throws {
        let testQueue = DispatchQueue(label: #function)
        let await = XCTestExpectation(description: #function)
        var result:Bool?
        testQueue.async {
            DispatchQueue.main.async {
                checkQueue(queue: .main, result: &result)
                await.fulfill()
            }
        }
        wait(for: [await], timeout: 1)
        let returned = try XCTUnwrap(result)
        XCTAssertTrue(returned)
    }
    func testItemUIComposerIsOnMainQueue() throws {
        let await = XCTestExpectation(description: #function)
        let spec = ItemViewControllerSpecSpy()
        let sut = MainThreadDecorator(loader: spec)
        var result:Bool? = nil
        sut.items {  (_) in
            checkQueue(queue: .main, result: &result)
            await.fulfill()
        }
        wait(for: [await], timeout: 1)
        let returned = try XCTUnwrap(result)
        XCTAssertTrue(returned)
    }
}


func checkQueue(queue: DispatchQueue, result: inout Bool?){
    result = queue == OperationQueue.current?.underlyingQueue
}
