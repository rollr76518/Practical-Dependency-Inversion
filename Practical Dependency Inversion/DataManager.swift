//
//  DataManager.swift
//  Practical Dependency Inversion
//
//  Created by Hanyu on 2020/6/11.
//  Copyright © 2020 Hanyu. All rights reserved.
//

import Foundation

class DataMananger: NSObject {
    
    func items(completion: @escaping (Result<[Item], Error>) -> Void) {
        ApiClient.shared.fetch { (result) in
            switch result {
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode([Item].self, from: data)
                    completion(.success(items))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
