//
//  AppButtons.swift
//  test-app
//
//  Created by maxim mironov on 05/05/2019.
//  Copyright © 2019 maxim mironov. All rights reserved.
//

import UIKit
class FormButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 1
        layer.borderColor = UIColor.blue.cgColor
        layer.cornerRadius = frame.height / 4
        setTitleColor(UIColor.blue, for: .normal)
    }
}
