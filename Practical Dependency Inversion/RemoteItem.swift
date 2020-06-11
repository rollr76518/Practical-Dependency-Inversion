//
//  Item.swift
//  Practical Dependency Inversion
//
//  Created by Hanyu on 2020/6/11.
//  Copyright © 2020 Hanyu. All rights reserved.
//

import Foundation

struct RemoteItem: Codable {
    let titleText: String
    let contentText: String
    let imageURL: URL
}
