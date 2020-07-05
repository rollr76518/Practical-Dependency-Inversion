//
//  PrimaryWithFallbackLoader.swift
//  Practical Dependency Inversion
//
//  Created by hanyu on 2020/7/5.
//  Copyright © 2020 Hanyu. All rights reserved.
//

import Foundation

class PrimaryWithFallbackLoader {
    
    private let primaryLoader: ItemsViewControllerSpec
    private let fallbackLoader: ItemsViewControllerSpec
    
    init(primaryLoader: ItemsViewControllerSpec, fallbackLoader: ItemsViewControllerSpec) {
        self.primaryLoader = primaryLoader
        self.fallbackLoader = fallbackLoader
    }
}

extension PrimaryWithFallbackLoader: ItemsViewControllerSpec {
    
    func items(completion: @escaping (Result<[Item], Error>) -> Void) {
        primaryLoader.items { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                completion(.success(items))
            case .failure:
                self.fallbackLoader.items(completion: completion)
            }
        }
    }
}
