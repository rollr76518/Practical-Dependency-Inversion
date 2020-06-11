//
//  ApiClient.swift
//  Practical Dependency Inversion
//
//  Created by Hanyu on 2020/6/11.
//  Copyright © 2020 Hanyu. All rights reserved.
//

import Foundation

class ApiClient: NSObject {
    
    static let shared = ApiClient()
    
    func fetch(completion: @escaping ((Result<Data, Error>) -> Void)) {
        completion(.success(Data()))
    }
}
