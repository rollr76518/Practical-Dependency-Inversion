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
        testQueue.async {
            XCTAssertFalse(isMainQueue())
            await.fulfill()
        }
        wait(for: [await], timeout: 1)
    }
    func testCanCheckIsOnMainQueue() throws {
        let testQueue = DispatchQueue(label: #function)
        let await = XCTestExpectation(description: #function)
        testQueue.async {
            XCTAssertFalse(isMainQueue())
            DispatchQueue.main.async {
                XCTAssertTrue(isMainQueue())
                await.fulfill()
            }
        }
        wait(for: [await], timeout: 1)
    }
    
    class ItemViewControllerSpecCustomQueue: ItemsViewControllerSpec {
        internal init(_ contiueQueue: DispatchQueue) {
            self.contiueQueue = contiueQueue
        }
        
        static let queueName = "Custom Queue"
        lazy var queue = DispatchQueue(label: Self.queueName)
        var contiueQueue: DispatchQueue
        private(set) var isFetched: Bool = false
        
        func items(completion: @escaping (Result<[Item], Error>) -> Void) {
            queue.async {
            print(2)
                self.isFetched = true
                self.contiueQueue.async {
                    completion(.success([]))
                }
            }
        }
    }
    
    func testItemUIComposerfromNotMainQueue() throws {
        let queue = DispatchQueue(label: #function)
        let await = XCTestExpectation(description: #function)
        let spec = ItemViewControllerSpecCustomQueue(queue)
        let sut = MainThreadDecorator(loader: spec)
        sut.items {  (_) in
            XCTAssertTrue(isMainQueue())
            await.fulfill()
        }
        wait(for: [await], timeout: 1)
    }
}

func isMainQueue() -> Bool{
    let clabel = __dispatch_queue_get_label(nil)
    let currectLabel = String(cString: clabel)
    return currectLabel == DispatchQueue.main.label
}
