//
//  DateExtensions.swift
//  test-app
//
//  Created by maxim mironov on 06/05/2019.
//  Copyright © 2019 maxim mironov. All rights reserved.
//

import Foundation
extension Date{
    func mediumDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}

