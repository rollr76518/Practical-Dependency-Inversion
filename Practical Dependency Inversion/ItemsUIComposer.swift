//
//  ItemsComposer.swift
//  Practical Dependency Inversion
//
//  Created by hanyu on 2020/7/5.
//  Copyright © 2020 Hanyu. All rights reserved.
//

import Foundation

class ItemsUIComposer {
    
    class func itemViewController() -> ItemsViewController {
        let remoteLoader = RemoteLoader()
        let localLoader = LocalLoader()
        let loader = PrimaryWithFallbackLoader(primaryLoader: remoteLoader, fallbackLoader: localLoader)
        return ItemsViewController(spec: MainThreadDecorator(loader: loader))
    }
}

class MainThreadDecorator: ItemsViewControllerSpec {
    
    private let loader: ItemsViewControllerSpec
    private static var didSetSpecific = false
    private static let mainQueueKey = DispatchSpecificKey<Int>()
    private static let mainQueueValue = 1
    
    init(loader: ItemsViewControllerSpec) {
        self.loader = loader
        if Self.didSetSpecific {
            return
        }
        DispatchQueue.main.setSpecific(key: Self.mainQueueKey, value: 1)
        Self.didSetSpecific = true
    }
    
    func items(completion: @escaping (Result<[Item], Error>) -> Void) {
        guard (DispatchQueue.getSpecific(key: Self.mainQueueKey) == Self.mainQueueValue) else {
            DispatchQueue.main.async(execute: { self.loader.items(completion: completion)} )
            return
        }
        loader.items(completion: completion)
    }
}
