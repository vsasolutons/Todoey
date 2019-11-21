//
//  Category.swift
//  Todoey
//
//  Created by Kevin Morris on 11/21/19.
//  Copyright © 2019 Kevin Morris. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
