//
//  LocalLoader.swift
//  Practical Dependency Inversion
//
//  Created by hanyu on 2020/7/5.
//  Copyright © 2020 Hanyu. All rights reserved.
//

import Foundation

class LocalLoader {

}

extension LocalLoader: ItemsViewControllerSpec {
    
    func items(completion: @escaping (Result<[Item], Error>) -> Void) {
        //Do Local datebase/cache
        completion(.success([]))
    }
}
