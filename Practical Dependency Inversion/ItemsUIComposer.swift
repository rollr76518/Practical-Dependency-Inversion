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
        return ItemsViewController(spec: loader)
    }
}
