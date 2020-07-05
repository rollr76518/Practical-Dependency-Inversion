//
//  RemoteLoader.swift
//  Practical Dependency Inversion
//
//  Created by hanyu on 2020/7/5.
//  Copyright © 2020 Hanyu. All rights reserved.
//

import Foundation

class RemoteLoader {
    
}

extension RemoteLoader: ItemsViewControllerSpec {
    
    func items(completion: @escaping (Result<[Item], Error>) -> Void) {
        //Do API Client
        completion(.success([]))
    }
}
