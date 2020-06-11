//
//  DataManager.swift
//  Practical Dependency Inversion
//
//  Created by Hanyu on 2020/6/11.
//  Copyright © 2020 Hanyu. All rights reserved.
//

import Foundation

class DataMananger: NSObject {

}

extension DataMananger: ItemsViewControllerSpec {
    
    func items(completion: @escaping (Result<[Item], Error>) -> Void) {
        ApiClient.shared.fetch { (result) in
            switch result {
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode([RemoteItem].self, from: data)
                    completion(.success(items.toItems()))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension Array where Element == RemoteItem {
    
    func toItems() -> [Item] {
        return self.map { (RemoteItem) -> Item in
            return Item(titleText: RemoteItem.titleText,
                        contentText: RemoteItem.contentText)
        }
    }
}
