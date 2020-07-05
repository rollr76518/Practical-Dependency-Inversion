//
//  ItemsViewControllerTests.swift
//  Practical Dependency InversionTests
//
//  Created by hanyu on 2020/7/5.
//  Copyright © 2020 Hanyu. All rights reserved.
//

import XCTest
@testable import Practical_Dependency_Inversion

class ItemsViewControllerTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_loader_worksAtViewDidLoad() {
        let spec = ItemViewControllerSpecSpy()
        let sut = ItemsViewController(spec: spec)
        
        sut.loadViewIfNeeded()
        XCTAssertTrue(spec.isFetched)
    }

}

//MARK: - Helper:

class ItemViewControllerSpecSpy: ItemsViewControllerSpec {
    
    private(set) var isFetched: Bool = false
    
    func items(completion: @escaping (Result<[Item], Error>) -> Void) {
        isFetched = true
        completion(.success([]))
    }
}
