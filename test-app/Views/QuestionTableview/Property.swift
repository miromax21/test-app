//
//  Property.swift
//  test-app
//
//  Created by maxim mironov on 20/05/2019.
//  Copyright © 2019 maxim mironov. All rights reserved.
//

import Foundation
struct Property {
    var pageNumber: Int = 1
    var tags: [String] = ["swift", "ios", "xcode", "cocoa-touch", "iphone"]
    var currentTagIndex:Int = 0
    var itemsCountOnPage: Int = 10
}
